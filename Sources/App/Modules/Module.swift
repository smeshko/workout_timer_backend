import Vapor
import Fluent

protocol Module {
    var router: RouteCollection? { get }
    var migrations: [Migration] { get }
    
    func seeds(_ env: Environment) -> [SeedMigration]
    func runSeeds(_ app: Application)
    func configure(_ app: Application) throws
}

extension Module {
    var router: RouteCollection? { nil }
    var migrations: [Migration] { [] }
    
    func seeds(_ env: Environment) -> [SeedMigration] { [] }
    
    func configure(_ app: Application) throws {        
        migrations.forEach { app.migrations.add($0) }

        if let router = self.router {
            try router.boot(routes: app.routes)
        }
    }

    func runSeeds(_ app: Application) {
        seeds(app.environment).forEach { app.migrations.add($0) }
    }
}
