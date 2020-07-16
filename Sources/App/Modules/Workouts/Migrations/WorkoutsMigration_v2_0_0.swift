import Foundation
import Fluent

struct WorkoutsMigration_v2_0_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .field(Workout.FieldKeys.level, .string)
                .field(Workout.FieldKeys.createdAt, .date)
                .field(Workout.FieldKeys.updatedAt, .date)
                .field(Workout.FieldKeys.muscles, .array(of: .string))
                .update(),
            
            database.schema(Exercise.schema)
                .field(Exercise.FieldKeys.level, .string)
                .field(Exercise.FieldKeys.createdAt, .date)
                .field(Exercise.FieldKeys.updatedAt, .date)
                .field(Workout.FieldKeys.muscles, .array(of: .string))
                .update()
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.makeSucceededFuture(())
    }
}
