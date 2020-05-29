import Fluent
import Vapor
@testable import App

class TestSeed: Migration {
    
    let exercises: [Exercise] =
    [
        Exercise(name: "Mock Exercise 1", imageKey: "path/to/image1", thumbnailKey: "path/to/thumbnail1"),
        Exercise(name: "Mock Exercise 2", imageKey: "path/to/image2", thumbnailKey: "path/to/thumbnail2"),
        Exercise(name: "Mock Exercise 3", imageKey: "path/to/image3", thumbnailKey: "path/to/thumbnail3"),
    ]
    
    let category = Category(name: "Mock Category")
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            WorkoutsMigration_v1_0_0().prepare(on: database),
            WorkoutsMigration_v1_1_0().prepare(on: database),
            WorkoutsMigration_v1_2_0().prepare(on: database),
            WorkoutsMigration_v1_3_0().prepare(on: database),
            WorkoutsMigration_v1_6_0().prepare(on: database),
        
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.makeSucceededFuture(())
    }
}
