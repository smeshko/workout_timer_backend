import Foundation
import Fluent

struct WorkoutsMigration_v1_0_0: Migration {
    
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema)
                .id()
                .field("image", .string, .required)
                .field(Workout.FieldKeys.name, .string, .required)
                .create(),
            database.schema(Exercise.schema)
                .id()
                .field("image", .string, .required)
                .field(Exercise.FieldKeys.name, .string, .required)
                .create(),
            database.schema(ExerciseSet.schema)
                .id()
                .field(ExerciseSet.FieldKeys.duration, .double, .required)
                .field(ExerciseSet.FieldKeys.exericseId, .uuid, .required)
                .field(ExerciseSet.FieldKeys.workoutId, .uuid, .required)
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
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(Workout.schema).delete(),
            database.schema(Exercise.schema).delete(),
        ])
    }
}
