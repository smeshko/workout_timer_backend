import Fluent
import Vapor

struct WorkoutsMigration_v1_9_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            ExerciseSet.query(on: database).delete(),
            Workout.query(on: database).delete(),
            Category.query(on: database).delete(),
            WorkoutsMigration_v1_8_0().prepare(on: database)
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        WorkoutsMigration_v1_8_0().revert(on: database)
    }
}
