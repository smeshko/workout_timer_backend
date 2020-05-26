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
        try configure(app)
        return app
    }
}
