import Fluent
import FluentPostgresDriver
import Vapor

extension Environment {
    static var staging: Environment {
        .custom(name: "staging")
    }
    
    static let pgUser = Environment.get("PG_USER")!
    static let pgDatabase = Environment.get("PG_DB")!
    static let pgPassword = Environment.get("PG_PW")!
    static let pgHost = Environment.get("PG_HOST")!
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
        UsersModule(),
        ImagesModule(),
        CategoriesModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
    
    try app.autoMigrate().wait()
}
