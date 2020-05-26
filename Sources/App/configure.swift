import Fluent
import FluentPostgresDriver
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
//    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    
    let config = PostgresConfiguration(
        hostname: "ec2-54-246-90-10.eu-west-1.compute.amazonaws.com",
        port: 5432,
        username: "ybqkqvgysvuevv",
        password: "1ac0c7156797feae41368d5e90a8c0a185dbf1c6bcbaf3a0f22652e8bc35b204",
        database: "dcbujqdvobjell"
    )
    
    app.databases.use(.postgres(configuration: config), as: .psql)

    // Configure modules
    let modules: [Module] = [
        WorkoutModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
    
    try app.autoMigrate().wait()
}
