import Fluent
import Vapor

struct WorkoutsMigration_v1_4_0: Migration {
    
    let exercises =
        [
            Exercise(name: "Freestyle Jumping", imageKey: "/images/exercises/jumprope/freestyle.png"),
            Exercise(name: "Double Unders", imageKey: "/images/exercises/jumprope/double-unders.png")
        ]

    let workout = Workout(name: "Sample workout", imageKey: "/images/workouts/sample.png")
    
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        exercises.create(on: database).flatMap {
            self.workout
                .create(on: database)
                .flatMap {
                    Exercise
                        .query(on: database)
                        .all()
                        .flatMap { exercises in
                            let set = ExerciseSet(duration: 30, exerciseId: exercises.first!.id!, workoutId: self.workout.id!)
                            return set.create(on: database)
                        }
                }
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            Workout.query(on: database).delete(),
            Exercise.query(on: database).delete(),
            ExerciseSet.query(on: database).delete(),
        ])
    }
}
