import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver
import Vapor
import Liquid
import LiquidLocalDriver

extension Environment {
    static let pgUrl = URL(string: Self.get("DB_URL")!)!
    static let appUrl = URL(string: Self.get("APP_URL")!)!
    static let awsKey = Self.get("AWS_KEY")!
    static let awsSecret = Self.get("AWS_SECRET")!
}

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"

    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
    // Configure SQLite database
//    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
//    try app.databases.use(.postgres(url: Environment.pgUrl), as: .psql)
    app.databases.use(.postgres(hostname: "localhost", username: "smeshko", password: "darkknight1", database: "workout_timer"), as: .psql)


    
    // Configure modules
    let modules: [Module] = [
        WorkoutModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
}
