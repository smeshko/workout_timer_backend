import Foundation
import Fluent

struct WorkoutsMigration_v1_0_0: Migration {
    
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .id()
                .field(Workout.FieldKeys.image, .string, .required)
                .field(Workout.FieldKeys.name, .string, .required)
                .create(),
            database.schema(Exercise.schema)
                .id()
                .field(Exercise.FieldKeys.image, .string, .required)
                .field(Exercise.FieldKeys.name, .string, .required)
                .create(),
            database.schema(ExerciseSet.schema)
                .id()
                .field(ExerciseSet.FieldKeys.duration, .double, .required)
                .field(ExerciseSet.FieldKeys.exericseId, .string, .required)
                .field(ExerciseSet.FieldKeys.workoutId, .string, .required)
                .foreignKey(ExerciseSet.FieldKeys.exericseId,
                            references: Exercise.schema,
                            .id,
                            onDelete: DatabaseSchema.ForeignKeyAction.setNull,
                            onUpdate: .cascade)
                .foreignKey(ExerciseSet.FieldKeys.workoutId,
                            references: Workout.schema,
                            .id,
                            onDelete: DatabaseSchema.ForeignKeyAction.setNull,
                            onUpdate: .cascade)
                .create(),
        ])
            .flatMap {
                let exercises =
                    [
                        Exercise(name: "Freestyle Jumping", image: "/images/exercises/jumprope/freestyle.png"),
                        Exercise(name: "Double Unders", image: "/images/exercises/jumprope/double-unders.png")
                ]
                
                return exercises.create(on: database)
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> { database.eventLoop.flatten([
        database.schema(Workout.schema).delete(),
        database.schema(Exercise.schema).delete(), ])
    }
}
