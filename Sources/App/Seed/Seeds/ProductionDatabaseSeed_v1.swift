import Foundation
import Fluent

struct ProductionDatabaseSeed_v1: Seed {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            categories.create(on: database),
            exercises.create(on: database),
            workouts.create(on: database),
            sets.create(on: database)
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            sets.delete(on: database),
            exercises.delete(on: database),
            workouts.delete(on: database),
            categories.delete(on: database)
        ])
    }
    
    private var sets: [ExerciseSet] {
        Workout.fullBoxerRoutine.sets
    }

    private var workouts: [Workout] {
        [
            Workout.fullBoxerRoutine.workout
        ]
    }
    
    private var categories: [Category] {
        [
            .cardio,
            .strength,
            .boxing
        ]
    }
    
    private var exercises: [Exercise] {
        [
            .crissCross,
            .boxerStep,
            .doubleUnder,
            .jumpRopeRunInPlace,
            .jumpRopeFreestyle,
            .jumpRopeHighKnees,
            .jumpRopeFrontToBack,
            .basicJump,
            .jumpRopeSideToSide,
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
            .quadRockers
        ]
    }
}

private extension Exercise {
    static let steps = [
        "This is Step 1. As easy as it gets.",
        "Step 2. Keep going.",
        "This is step 3 and it's longer than usual. It mimics a longer explanation that should be somehow handled by the clients. This shouldn't be the case often, but let's have it just in case!",
        "Step 4 should be the last one"
    ]
    
    static let crissCross = Exercise(
        id: UUID(),
        name: "Criss Cross",
        imageKey: "images/exercises/jumprope/criss-cross.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/criss-cross.jpg",
        level: .intermediate,
        muscles: [.calves],
        steps: steps
    )
    
    static let boxerStep = Exercise(
        id: UUID(),
        name: "Boxer steps",
        imageKey: "images/exercises/jumprope/boxer-step.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/boxer-step.jpg",
        level: .beginner,
        muscles: [.calves],
        steps: steps
    )
    
    static let doubleUnder = Exercise(
        id: UUID(),
        name: "Double Unders",
        imageKey: "images/exercises/jumprope/double-unders.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/double-unders.jpg",
        level: .expert,
        muscles: [.calves],
        steps: steps
    )
    
    static let jumpRopeRunInPlace = Exercise(
        id: UUID(),
        name: "Run in Place",
        imageKey: "images/exercises/jumprope/run-in-place.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/run-in-place.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeFreestyle = Exercise(
        id: UUID(),
        name: "Freestyle",
        imageKey: "images/exercises/jumprope/freestyle.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/freestyle.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeHighKnees = Exercise(
        id: UUID(),
        name: "High Knees",
        imageKey: "images/exercises/jumprope/high-knees.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/high-knees.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeFrontToBack = Exercise(
        id: UUID(),
        name: "Front to Back",
        imageKey: "images/exercises/jumprope/front-to-back.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/front-to-back.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let basicJump = Exercise(
        id: UUID(),
        name: "Simple Jump",
        imageKey: "images/exercises/jumprope/simple-jump.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/simple-jump.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeSideToSide = Exercise(
        id: UUID(),
        name: "Side to Side",
        imageKey: "images/exercises/jumprope/side-to-side.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/side-to-side.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let heavyRopeJumping = Exercise(
        id: UUID(),
        name: "Heavy rope jumping",
        imageKey: "images/exercises/jumprope/heavy-rope-jumping.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/heavy-rope-jumping.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let jumpingJacks = Exercise(
        id: UUID(),
        name: "Jumping jacks",
        imageKey: "images/exercises/bodyweight/jumping-jack.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/jumping-jack.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let pushUps = Exercise(
        id: UUID(),
        name: "Push ups",
        imageKey: "images/exercises/bodyweight/push-up.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/push-up.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let pullUps = Exercise(
        id: UUID(),
        name: "Pull ups",
        imageKey: "images/exercises/bodyweight/pull-up.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/pull-up.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let shadowBoxing = Exercise(
        id: UUID(),
        name: "Shadow Boxing",
        imageKey: "images/exercises/bodyweight/shadow-boxing.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/shadow-boxing.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let boatToLowBoat = Exercise(
        id: UUID(),
        name: "Boat to low Boat",
        imageKey: "images/exercises/bodyweight/low-boat.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/low-boat.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let oneArmShoulderTouches = Exercise(
        id: UUID(),
        name: "One Arm Shoulder Touches",
        imageKey: "images/exercises/bodyweight/plank.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let bicycles = Exercise(
        id: UUID(),
        name: "Bicycles",
        imageKey: "images/exercises/bodyweight/bicycles.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/bicycles.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let plank = Exercise(
        id: UUID(),
        name: "High Plank",
        imageKey: "images/exercises/bodyweight/plank.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let lyingTStretch = Exercise(
        id: UUID(),
        name: "Lying T Stretch",
        imageKey: "images/exercises/bodyweight/lying-t-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/lying-t-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let figureFourStretch = Exercise(
        id: UUID(),
        name: "Figure Four Stretch",
        imageKey: "images/exercises/bodyweight/figure-four-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/figure-four-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let lyingHamstringStretch = Exercise(
        id: UUID(),
        name: "Lying Hamstring Stretch",
        imageKey: "images/exercises/bodyweight/lying-hamstring-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/lying-hamstring-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let quadRockers = Exercise(
        id: UUID(),
        name: "Quad Rockers",
        imageKey: "images/exercises/bodyweight/quad-rockers.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/quad-rockers.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let recovery = Exercise(
        id: UUID(),
        name: "Recovery",
        imageKey: "images/exercises/bodyweight/recovery.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/recovery.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
}

private extension Category {
    static let cardio = Category(
        id: UUID(),
        name: "Cardio"
    )
    
    static let strength = Category(
        id: UUID(),
        name: "Strength"
    )
    
    static let boxing = Category(
        id: UUID(),
        name: "Boxing"
    )
}

private extension Workout {
    static let fullBoxerRoutine: (workout: Workout, sets: [ExerciseSet]) = {
        let workout = Workout(
            id: UUID(),
            name: "Boxer Burner",
            imageKey: "images/workouts/complete-routine.jpg",
            thumbnailKey: "thumbnails/workouts/complete-routine.jpg",
            categoryId: Category.boxing.id!,
            level: .intermediate,
            muscles: [.calves]
        )
        
        return (
            workout: workout,
            sets: [
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .jumpRopeFreestyle, duration: 180),
                .recovery(60, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .pushUps, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .pushUps, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .pushUps, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 30),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 30),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 30),
                .recovery(60, workout: workout),
                ExerciseSet(workout: workout, exercise: .shadowBoxing, duration: 120),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .bicycles, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .shadowBoxing, duration: 120),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .oneArmShoulderTouches, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .shadowBoxing, duration: 120),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .boatToLowBoat, duration: 60),
                .recovery(30, workout: workout),
                ExerciseSet(workout: workout, exercise: .shadowBoxing, duration: 120),
                .recovery(45, workout: workout),
                ExerciseSet(workout: workout, exercise: .plank, duration: 60),
                .recovery(10, workout: workout),
                ExerciseSet(workout: workout, exercise: .lyingTStretch, duration: 30, type: .cooldown),
                .recovery(10, workout: workout),
                ExerciseSet(workout: workout, exercise: .lyingTStretch, duration: 30, type: .cooldown),
                .recovery(10, workout: workout),
                ExerciseSet(workout: workout, exercise: .lyingHamstringStretch, duration: 30, type: .cooldown),
                .recovery(10, workout: workout),
                ExerciseSet(workout: workout, exercise: .lyingHamstringStretch, duration: 30, type: .cooldown),
                .recovery(10, workout: workout),
                ExerciseSet(workout: workout, exercise: .quadRockers, duration: 45, type: .cooldown)
        ])
    }()

}

private extension ExerciseSet {
    convenience init(workout: Workout, exercise: Exercise, duration: Double, type: ExerciseType = .workout) {
        self.init(id: UUID(), duration: duration, exerciseId: exercise.id!, workoutId: workout.id!, type: type)
    }
    
    static func recovery(_ duration: Double, workout: Workout) -> ExerciseSet {
        ExerciseSet(
            id: UUID(),
            duration: duration,
            exerciseId: Exercise.recovery.id!,
            workoutId: workout.id!,
            type: .rest
        )
    }
}
