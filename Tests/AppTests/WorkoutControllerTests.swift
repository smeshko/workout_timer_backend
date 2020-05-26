@testable import App
import Spec
import Fluent

final class WorkoutControllerTests: AppTestCase {
    func testGetWorkouts() throws {
//        let app = try createTestApp()
        let app = Application(.testing)
        defer { app.shutdown() }

        app.databases.use(try .postgres(url: Environment.get("DATABASE_URL")!), as: .psql, isDefault: true)
        try configure(app)


        
        try app
            .describe("Workouts should return ok")
            .get("/api/workouts")
            .expect(.ok)
            .expect(.json)
            .expect(Page<Workout.ListItem>.self) { content in
                XCTAssertEqual(content.metadata.total, 1)
            }
            .test()
    }
}
