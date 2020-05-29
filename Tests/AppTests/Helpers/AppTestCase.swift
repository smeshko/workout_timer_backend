@testable import App
import FluentPostgresDriver
import XCTVapor

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
        app.databases.use(try .postgres(url: "postgres://test:test@postgres:5432/test"), as: .psql, isDefault: true)
        try configure(app)
        try app.autoMigrate().wait()
        return app
    }
}
