import Fluent
import Vapor

struct WorkoutsMigration_v1_8_0: Migration {
    
    let workouts = Workout.seed.map { name, _ in Workout(name: name) }
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        workouts
            .create(on: database)
            .flatMap {
                Exercise
                    .query(on: database)
                    .all()
                    .flatMap { (exercises: [Exercise]) in
                        
                        let idsMap: [String: UUID] = exercises.reduce(into: [:]) { result, exercise in
                            result[exercise.name] = exercise.id!
                        }
                        
                        return self.workouts.compactMap { workout in
                            Workout.seed[workout.name]?.compactMap { name, duration in
                                ExerciseSet(duration: duration, exerciseId: idsMap[name]!, workoutId: workout.id!)
                            }
                        }
                        .flatMap { $0 }
                        .create(on: database)
                }
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            ExerciseSet.query(on: database).delete(),
            Workout.query(on: database).delete(),
        ])
    }
}
