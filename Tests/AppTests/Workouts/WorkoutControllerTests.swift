@testable import App
import Spec
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver

final class WorkoutControllerTests: AppTestCase {
    
    func testListWorkouts() throws {
//        let app = try createTestApp()
        let app = Application(.testing)
        defer { app.shutdown() }

        app.databases.use(.postgres(url: "postgres://postgres:password@localhost:5432/testingdb"), as: .psql, isDefault: true)
        try configure(app)
        try app.autoMigrate().wait()


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