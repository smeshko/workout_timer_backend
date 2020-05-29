import Fluent

struct WorkoutsMigration_v1_7_0: Migration {
    
    let exercises: [Exercise] =
        [
            .crissCross,
            .doubleUnder,
            .boxerStep,
            .runInPlace,
            .freestyle,
            .highKnees,
            .frontToBack,
            .simpleJump,
            .sideToSide,
            .heavyRopeJumping,
            .jumpingJacks,
            .pushUps,
            .pullUps,
            .shadowBoxing,
            .boatToLowBoat,
            .oneArmShoulderTouches,
            .bicycles,
            .plank,
            .lyingTStretch,
            .figureFourStretch,
            .lyingHamstringStretch,
            .quadRockers,
            .recovery
        ]
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            ExerciseSet.query(on: database).delete(),
            Workout.query(on: database).delete(),
            Exercise.query(on: database).delete(),
            exercises.create(on: database)
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        Exercise.query(on: database).delete()
    }
}
