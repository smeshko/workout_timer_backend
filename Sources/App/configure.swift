import Fluent
import FluentPostgresDriver
import Vapor
import Liquid
import LiquidLocalDriver

extension Environment {
    static var staging: Environment {
        .custom(name: "staging")
    }
}

// Called before your application initializes.
public func configure(_ app: Application) throws {
    
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
    switch app.environment {
    case .production, .development, .staging:
        app.databases.use(try .postgres(url: Environment.get("DATABASE_URL") ?? ""), as: .psql)
    default: break
    }

    // Configure modules
    let modules: [Module] = [
        WorkoutModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
}
