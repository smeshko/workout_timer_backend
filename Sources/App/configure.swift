import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver
import Vapor
import Liquid
import LiquidLocalDriver

extension Environment {
//    static let pgUrl = URL(string: Self.get("DB_URL")!)!
//    static let appUrl = URL(string: Self.get("APP_URL")!)!
//    static let awsKey = Self.get("AWS_KEY")!
//    static let awsSecret = Self.get("AWS_SECRET")!
    
    
    
    
    static let dbHost = Self.get("DB_HOST")!
    static let dbUser = Self.get("DB_USER")!
    static let dbPass = Self.get("DB_PASS")!
    static let dbName = Self.get("DB_NAME")!
}

// Called before your application initializes.
public func configure(_ app: Application) throws {
    
    let configuration = PostgresConfiguration(
        hostname: Environment.dbHost,
        port: 5432,
        username: Environment.dbUser,
        password: Environment.dbPass,
        database: Environment.dbName
    )
    
    
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"

//    app.fileStorages.use(.awsS3(key: Environment.awsKey,
//                                    secret: Environment.awsSecret,
//                                    bucket: Environment.fsName,
//                                    region: Region.init(rawValue: Environment.fsRegion)), as: .awsS3)

    
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
    // Configure SQLite database
//    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
//    try app.databases.use(.postgres(url: Environment.pgUrl), as: .psql)
    app.databases.use(.postgres(configuration: configuration), as: .psql)


    
    // Configure modules
    let modules: [Module] = [
        WorkoutModule()
    ]
    
    try modules.forEach { try $0.configure(app) }
    
    try app.autoMigrate().wait()
}
