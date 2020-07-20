import Fluent

struct WorkoutsMigration_v1_2_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Category.schema)
                .id()
                .field(Category.FieldKeys.name, .string, .required)
                .create()
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Category.schema).delete()
    }
}
