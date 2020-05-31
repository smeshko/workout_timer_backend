@testable import App
import Vapor
import Spec
import Fluent

final class ImagesControllerTests: AppTestCase {
    
    func testGetImage() throws {
        let app = try createTestApp()
        defer { app.shutdown() }

        try app
            .describe("Get image should return data")
            .get("/api/images?imageKey=images/jumprope/exercises/freestyle.jpg")
            .expect(.ok)
            .test()
    }
}
