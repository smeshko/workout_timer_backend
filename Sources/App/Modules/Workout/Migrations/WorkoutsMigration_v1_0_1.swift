import Fluent

struct WorkoutsMigration_v1_0_1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let workout = Workout(name: "Sample workout", image: "/images/workouts/sample.png")
        return workout.create(on: database).flatMap {
            Exercise.query(on: database).all().flatMap { exercises in
                let set = ExerciseSet(duration: 30, exerciseId: exercises.first!.id!, workoutId: workout.id!)
                return set.create(on: database)
            }
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
        database.schema(Workout.schema).delete(),
        database.schema(Exercise.schema).delete(), ])
    }

}
