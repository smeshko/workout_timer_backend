@testable import App
import Spec
import Fluent

final class WorkoutControllerTests: AppTestCase {
    
    func testListWorkouts() throws {
        let app = try createTestApp()
        defer { app.shutdown() }

        try app
            .describe("Workouts should return ok")
            .get("/api/workouts")
            .expect(.ok)
            .expect(.json)
            .expect([Workout.ListItem].self) { content in
                XCTAssertEqual(content.count, 2)
            }
            .test()
    }
    
    func testGetWorkout() throws {
        let app = try createTestApp()
        defer { app.shutdown() }

        try app
            .describe("Get Workout should return ok")
            .get("/api/workouts/\(TestSeed.workoutId1)")
            .expect(.ok)
            .expect(.json)
            .expect(Workout.GetContent.self) { content in
                XCTAssertEqual(content.name, "Mock Workout 1")
                XCTAssertEqual(content.exerciseSets.count, 3)
            }
            .test()
    }
    
    func testGetWorkoutWithError() throws {
        let app = try createTestApp()
        defer { app.shutdown() }

        try app
            .describe("Get Workout should return ok")
            .get("/api/workouts/wrongId")
            .expect(.badRequest)
            .test()
    }

}
