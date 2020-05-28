import Fluent

struct WorkoutsMigration_v1_3_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Workout.schema)
            .field(Workout.FieldKeys.category, .uuid)
            .foreignKey(Workout.FieldKeys.category,
                        references: Category.schema,
                        .id,
                        onDelete: DatabaseSchema.ForeignKeyAction.setNull,
                        onUpdate: .cascade)
            .update()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Workout.schema).deleteField(Workout.FieldKeys.category).update()
    }
}

