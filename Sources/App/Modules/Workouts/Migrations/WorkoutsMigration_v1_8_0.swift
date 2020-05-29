import Fluent
import Vapor

struct WorkoutsMigration_v1_8_0: Migration {
    
    let workoutCategoryPairs = Workout.seed.map { (workoutName: $0.key, categoryName: $0.value.category) }
    let categories = Category.seed
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            // create all categories
            categories.create(on: database).flatMap {
                
                // transform the workout-category pairs to Workout models
                self.workoutCategoryPairs.compactMap { workoutPair -> Workout? in
                    guard let category = self.categories.first(where: { $0.name == workoutPair.categoryName }) else { return nil }
                    return Workout(name: workoutPair.workoutName,
                                   imageKey: "images/workouts/\(workoutPair.workoutName.convertToImageName())",
                                   thumbnailKey: "thumbnails/workouts/\(workoutPair.workoutName.convertToImageName())",
                                   categoryId: category.id!)
                }
                // add the workouts to the database
                .create(on: database)
            },
            // fetch all exercises
            Exercise.query(on: database).all()
                // transform them to a dictionary [exerciseName: exerciseId]
                .map {
                    $0.reduce(into: [:]) { result, exercise in
                        result[exercise.name] = exercise.id!
                    }
                }
                // fetch all workouts
                .flatMap { exerciseIdsMap in
                    Workout.query(on: database).all()
                        
                        // transform them to a dictionary [workoutName: workoutId]
                        .map { workouts in
                            (exerciseIdsMap, workouts.reduce(into: [:]) { result, workout in
                                result[workout.name] = workout.id!
                            })
                        }
                }
            .flatMap { (exerciseIdsMap, workoutIdsMap) in
                
                // go through all workouts in the seed
                Workout.seed.map { workout in
                    // for each set in the seed, create an ExerciseSet object using the ids from the 2 maps
                    workout.value.sets.compactMap { name, duration in
                        ExerciseSet(duration: duration, exerciseId: exerciseIdsMap[name]!, workoutId: workoutIdsMap[workout.key]!)
                    }
                }
                .flatMap { $0 }
                .create(on: database)
            }
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            ExerciseSet.query(on: database).delete(),
            Workout.query(on: database).delete(),
            Category.query(on: database).delete()
        ])
    }
}

private extension String {
    func convertToImageName() -> String {
        self.replacingOccurrences(of: " ", with: "-").lowercased()
    }
}
