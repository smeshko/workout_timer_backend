import Fluent

struct UserMigration_v1_1_0: Migration {
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserToken.schema)
            .id()
            .field(UserToken.FieldKeys.value, .string, .required)
            .field(UserToken.FieldKeys.userId, .uuid, .required)
            .foreignKey(UserToken.FieldKeys.userId, references: User.schema, .id)
            .unique(on: UserToken.FieldKeys.value)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(UserToken.schema).delete(),
        ])
    }
}
