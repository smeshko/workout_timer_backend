import Fluent
import FluentPostgresDriver
import Vapor

extension Environment {
    static var staging: Environment {
        .custom(name: "staging")
    }
}

// Called before your application initializes.
public func configure(_ app: Application) throws {
    
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    switch app.environment {
    case .production, .development, .staging:
        app.databases.use(try .postgres(url: Environment.get("DATABASE_URL") ?? ""), as: .psql)
    default: break
    }
    
    // Configure modules
    let modules: [Module] = [
        WorkoutsModule(),
        CategoriesModule(),
        UsersModule(),
        ImagesModule(),
    ]

    try modules.forEach { try $0.configure(app) }
    modules.forEach { $0.runSeeds(app) }
}
