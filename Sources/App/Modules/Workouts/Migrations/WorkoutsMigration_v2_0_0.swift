import Foundation
import Fluent

struct WorkoutsMigration_v2_0_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            
            database.schema(Category.schema)
                .id()
                .field(Category.FieldKeys.name, .string, .required)
                .create(),
            
            database.schema(Exercise.schema)
                .id()
                .field(Exercise.FieldKeys.thumbnailKey, .string)
                .field(Exercise.FieldKeys.imageKey, .string)
                .field(Exercise.FieldKeys.name, .string, .required)
                .field(Exercise.FieldKeys.level, .int)
                .field(Exercise.FieldKeys.createdAt, .datetime)
                .field(Exercise.FieldKeys.updatedAt, .datetime)
                .field(Exercise.FieldKeys.muscles, .array(of: .string))
                .field(Exercise.FieldKeys.steps, .array(of: .string))
                .create(),

            database.schema(Workout.schema)
                .id()
                .field(Workout.FieldKeys.thumbnailKey, .string)
                .field(Workout.FieldKeys.imageKey, .string)
                .field(Workout.FieldKeys.name, .string, .required)
                .field(Workout.FieldKeys.level, .int)
                .field(Workout.FieldKeys.createdAt, .datetime)
                .field(Workout.FieldKeys.updatedAt, .datetime)
                .field(Workout.FieldKeys.muscles, .array(of: .string))
                .field(Workout.FieldKeys.category, .uuid)
                .foreignKey(Workout.FieldKeys.category,
                            references: Category.schema,
                            .id,
                            onDelete: DatabaseSchema.ForeignKeyAction.setNull,
                            onUpdate: .cascade)
                .create(),
            
            database.schema(ExerciseSet.schema)
                .id()
                .field(ExerciseSet.FieldKeys.duration, .double, .required)
                .field(ExerciseSet.FieldKeys.exericseId, .uuid, .required)
                .field(ExerciseSet.FieldKeys.workoutId, .uuid, .required)
                .field(ExerciseSet.FieldKeys.exerciseType, .string, .required)
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
                .create()
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ExerciseSet.schema).delete(),
            database.schema(Workout.schema).delete(),
            database.schema(Exercise.schema).delete(),
            database.schema(Category.schema).delete(),
        ])
    }
}
