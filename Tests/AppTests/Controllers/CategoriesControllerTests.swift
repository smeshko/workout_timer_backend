@testable import App
import Spec
import Fluent

final class CategoriesControllerTests: AppTestCase {
    
    func testListCategories() throws {
        let app = try createTestApp()
        defer { app.shutdown() }

        try app
            .describe("Categories should return ok")
            .get("/api/categories/public")
            .expect(.ok)
            .expect(.json)
            .expect([App.Category.ListItem].self) { content in
                XCTAssertEqual(content.count, 1)
                XCTAssertEqual(content.first?.workouts?.count, 2)
                XCTAssertEqual(content.first?.workouts?.first?.name, "Mock Workout 1")
            }
            .test()
    }
}
