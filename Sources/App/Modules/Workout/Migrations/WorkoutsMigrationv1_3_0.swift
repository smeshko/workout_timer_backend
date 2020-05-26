import Fluent

struct WorkoutsMigration_v1_3_0: Migration {
    
    let exercises =
        [
            Exercise(name: "Boxer steps", image: "/images/exercises/jumprope/boxer-steps.png"),
            Exercise(name: "Criss cross", image: "/images/exercises/jumprope/criss-cross.png")
        ]
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        exercises.create(on: database)
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        Exercise.query(on: database).delete()
    }
}
