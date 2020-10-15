import Fluent
import Vapor
@testable import App

class TestSeed: Migration {
    
    static let workoutId1 = UUID()
    static let workoutId2 = UUID()
    
    let exercises: [Exercise] =
    [
        Exercise(name: "Mock Exercise 1", imageKey: "path/to/image1", thumbnailKey: "path/to/thumbnail1"),
        Exercise(name: "Mock Exercise 2", imageKey: "path/to/image2", thumbnailKey: "path/to/thumbnail2"),
        Exercise(name: "Mock Exercise 3", imageKey: "path/to/image3", thumbnailKey: "path/to/thumbnail3"),
    ]
    
    let category = Category(name: "Mock Category")
    
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            WorkoutsMigration_v2_0_0().prepare(on: database),
            CategoriesMigration_v1_0_0().prepare(on: database),
            exercises.create(on: database),
            category.create(on: database),
            
            [
                Workout(id: TestSeed.workoutId1, name: "Mock Workout 1", imageKey: "path/to/workoutimage1", thumbnailKey: "path/to/workoutthumbnail1", categoryId: category.id!),
                Workout(id: TestSeed.workoutId2, name: "Mock Workout 2", imageKey: "path/to/workoutimage2", thumbnailKey: "path/to/workoutthumbnail2", categoryId: category.id!)
            ]
                .create(on: database),
            
            [
                ExerciseSet(duration: 30, exerciseId: exercises.first!.id!, workoutId: TestSeed.workoutId1),
                ExerciseSet(duration: 45, exerciseId: exercises.first!.id!, workoutId: TestSeed.workoutId1),
                ExerciseSet(duration: 60, exerciseId: exercises.first!.id!, workoutId: TestSeed.workoutId1),
            
                ExerciseSet(duration: 30, exerciseId: exercises[1].id!, workoutId: TestSeed.workoutId2),
                ExerciseSet(duration: 45, exerciseId: exercises[1].id!, workoutId: TestSeed.workoutId2),
                ExerciseSet(duration: 60, exerciseId: exercises[1].id!, workoutId: TestSeed.workoutId2),
            ]
                .create(on: database)
            
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.makeSucceededFuture(())
    }
}
