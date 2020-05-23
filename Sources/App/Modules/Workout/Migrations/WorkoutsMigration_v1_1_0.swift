import Fluent

struct WorkoutsMigration_v1_1_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .field(Workout.FieldKeys.imageKey, .string)
                .update(),
            database.schema(Exercise.schema)
                .field(Exercise.FieldKeys.imageKey, .string)
                .update(),
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .deleteField(Workout.FieldKeys.imageKey)
                .update(),
            database.schema(Workout.schema)
                .deleteField(Workout.FieldKeys.imageKey)
                .update()
        ])
    }
}
