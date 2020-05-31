@testable import App
import FluentPostgresDriver
import XCTVapor

extension Environment {
    static let pgUser = Environment.get("PG_USER")!
    static let pgDatabase = Environment.get("PG_DB")!
    static let pgPassword = Environment.get("PG_PW")!
    static let pgHost = Environment.get("PG_HOST")!
}

open class AppTestCase: XCTestCase {
    func createTestApp() throws -> Application {
        let app = Application(.testing)
        
        app.configurePsql()
        
        try app.recreateDatabase()
        try app.configure()
        
        return app
    }
}

extension Application {
    
    func configurePsql() {
        let config = PostgresConfiguration(
            hostname: Environment.pgHost,
            port: 5432,
            username: Environment.pgUser,
            password: Environment.pgPassword,
            database: Environment.pgDatabase)

        databases.use(.postgres(configuration: config), as: .psql, isDefault: true)
    }
    
    func recreateDatabase() throws {
        let database = databases.database(.psql, logger: Logger(label: "psql.test"), on: eventLoopGroup.next())
        _ = try (database as! PostgresDatabase).query("drop schema public cascade").wait()
        _ = try (database as! PostgresDatabase).query("create schema public").wait()
    }
    
    func configure() throws {
        let modules: [Module] = [
            WorkoutsModule(),
            UsersModule(),
            ImagesModule(),
            CategoriesModule()
        ]
        
        try modules.forEach { try $0.router?.boot(routes: routes) }
        migrations.add(TestSeed())
        
        try autoMigrate().wait()
    }
}
