import Vapor
import Fluent

protocol SeedMigration: Migration {
    var seed: Seed { get }
}

protocol Seed {
    func prepare(on database: Database) -> EventLoopFuture<Void>
    func revert(on database: Database) -> EventLoopFuture<Void>
}
