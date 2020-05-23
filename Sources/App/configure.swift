import Fluent
import FluentSQLiteDriver
import Vapor
import Liquid
import LiquidLocalDriver

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
    // Configure SQLite database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    
    // Configure modules
    let modules: [Module] = [
        WorkoutModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
}
