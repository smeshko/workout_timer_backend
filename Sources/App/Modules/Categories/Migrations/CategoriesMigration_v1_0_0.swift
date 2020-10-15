import Fluent

struct CategoriesMigration_v1_0_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Category.schema)
                .field(Category.FieldKeys.createdAt, .datetime)
                .field(Category.FieldKeys.updatedAt, .datetime)
                .update()
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Category.schema)
                .deleteField(Category.FieldKeys.createdAt)
                .deleteField(Category.FieldKeys.updatedAt)
                .update()
        ])
    }
}
