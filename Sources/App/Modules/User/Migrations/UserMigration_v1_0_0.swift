import Fluent
import Vapor

struct UserMigration_v1_0_0: Migration {
    private func users() -> [User] {
        [User(email: "ivaylo.tsonev@example.com", password: try! Bcrypt.hash("password"))]
    }
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(User.schema)
                .id()
                .field(User.FieldKeys.email, .string, .required)
                .field(User.FieldKeys.password, .string, .required)
                .unique(on: User.FieldKeys.email)
                .create(),
        ]).flatMap {
            self.users().create(on: db) }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(User.schema).delete(),
        ])
    }
}
