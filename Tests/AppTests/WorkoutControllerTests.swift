@testable import App
import Spec
import Fluent

final class WorkoutControllerTests: AppTestCase {
    func testGetWorkouts() throws {
        let app = Application(.testing)
        defer { app.shutdown() }

        try configure(app)

        
        try app
            .describe("Blog posts should return ok")
            .get("/api/workouts")
            .expect(.ok)
            .expect(.json)
            .expect(Page<Workout.ListItem>.self) { content in
                XCTAssertEqual(content.metadata.total, 1)
            }
            .test()
    }
}
