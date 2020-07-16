import Vapor
import Fluent

struct WorkoutsModule: Module {
    var router: RouteCollection? { WorkoutsRouter() }
    
    var migrations: [Migration] {
        [
            WorkoutsMigration_v1_0_0(),
            WorkoutsMigration_v1_1_0(),
            WorkoutsMigration_v1_2_0(),
            WorkoutsMigration_v1_3_0(),
            WorkoutsMigration_v1_6_0(),
            WorkoutsMigration_v1_7_0(),
            WorkoutsMigration_v1_8_0(),
            WorkoutsMigration_v1_9_0(),
            WorkoutsMigration_v2_0_0(),
            NewMigration()
        ]
    }
}


private struct NewMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            [Exercise.crissCross, .boxerStep, .doubleUnder].create(on: database),
            Category.boxing.create(on: database),
            Workout.boxerBurner.workout.create(on: database),
            Workout.boxerBurner.sets.create(on: database)
        ])
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            ExerciseSet.query(on: database).delete(),
            Exercise.query(on: database).delete(),
            Workout.query(on: database).delete(),
            Category.query(on: database).delete()
        ])
        
    }
}
