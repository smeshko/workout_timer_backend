@testable import App
import FluentPostgresDriver
import XCTVapor

extension Environment {
    static let pgUser = Environment.get("PG_USER")!
    static let pgDatabase = Environment.get("PG_DB")!
    static let pgPassword = Environment.get("PG_PW")!
    static let pgHost = Environment.get("PG_HOST")!
}

extension XCTApplicationTester {
    @discardableResult public func test<T>(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        content: T,
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester where T: Content {
        try test(method, path, headers: headers, beforeRequest: { req in
            try req.content.encode(content)
        }, afterResponse: afterResponse)
    }
}

open class AppTestCase: XCTestCase {
    func createTestApp() throws -> Application {
        let app = Application(.testing)
        
        
        let config = PostgresConfiguration(
            hostname: Environment.pgHost,
            port: 5432,
            username: Environment.pgUser,
            password: Environment.pgPassword,
            database: Environment.pgDatabase)

        app.databases.use(.postgres(configuration: config), as: .psql, isDefault: true)
        try configure(app)
        try app.autoMigrate().wait()
        return app
    }
}
