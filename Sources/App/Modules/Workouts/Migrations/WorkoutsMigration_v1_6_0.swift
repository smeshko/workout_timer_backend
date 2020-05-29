import Fluent

struct WorkoutsMigration_v1_6_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .deleteField(Workout.FieldKeys.image)
                .field(Workout.FieldKeys.thumbnailKey, .string)
                .update(),
            database.schema(Exercise.schema)
                .deleteField(Exercise.FieldKeys.image)
                .field(Exercise.FieldKeys.thumbnailKey, .string)
                .update(),
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .deleteField(Workout.FieldKeys.thumbnailKey)
                .field(Workout.FieldKeys.image, .string)
                .update(),
            database.schema(Exercise.schema)
                .deleteField(Exercise.FieldKeys.thumbnailKey)
                .field(Exercise.FieldKeys.image, .string)
                .update(),
        ])
    }
}
