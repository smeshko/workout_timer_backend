@testable import App
import Spec
import Fluent
import FluentPostgresDriver

final class WorkoutControllerTests: AppTestCase {
    
    func testListWorkouts() throws {
//        let app = try createTestApp()
        let app = Application(.testing)
        defer { app.shutdown() }
        
        let config = PostgresConfiguration(
            hostname: Environment.pgHost,
            port: 5432,
            username: Environment.pgUser,
            password: Environment.pgPassword,
            database: Environment.pgDatabase)

        app.databases.use(.postgres(configuration: config), as: .psql, isDefault: true)
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
