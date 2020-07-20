import Foundation
import Fluent

struct StagingDatabaseSeed_v1: Seed {
    
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
    
    private let sets: [ExerciseSet] = Workout.fullBoxerRoutine.sets

    private let workouts: [Workout] =
        [
            Workout.fullBoxerRoutine.workout
        ]
    
    private let categories: [Category] =
        [
            .cardio,
            .strength,
            .boxing
        ]
    
    private let exercises: [Exercise] =
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
            .quadRockers,
            .recovery
        ]
}

private extension Exercise {
    static let steps = [
        "This is Step 1. As easy as it gets.",
        "Step 2. Keep going.",
        "This is step 3 and it's longer than usual. It mimics a longer explanation that should be somehow handled by the clients. This shouldn't be the case often, but let's have it just in case!",
        "Step 4 should be the last one"
    ]
    
    static let crissCross = Exercise(
        id: UUID(uuidString: "6324fe2f-4bc8-454c-9dfe-4e89833c3c05"),
        name: "Criss Cross",
        imageKey: "images/exercises/jumprope/criss-cross.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/criss-cross.jpg",
        level: .intermediate,
        muscles: [.calves],
        steps: steps
    )
    
    static let boxerStep = Exercise(
        id: UUID(uuidString: "695f3f35-0cd6-4b8c-b31e-57e70007129a"),
        name: "Boxer steps",
        imageKey: "images/exercises/jumprope/boxer-step.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/boxer-step.jpg",
        level: .beginner,
        muscles: [.calves],
        steps: steps
    )
    
    static let doubleUnder = Exercise(
        id: UUID(uuidString: "3c65284a-45a9-4ac5-bda5-f1bd9bc155c7"),
        name: "Double Unders",
        imageKey: "images/exercises/jumprope/double-unders.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/double-unders.jpg",
        level: .expert,
        muscles: [.calves],
        steps: steps
    )
    
    static let jumpRopeRunInPlace = Exercise(
        id: UUID(uuidString: "562439d5-3672-45b4-b862-16e38e1ccc1e"),
        name: "Run in Place",
        imageKey: "images/exercises/jumprope/run-in-place.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/run-in-place.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeFreestyle = Exercise(
        id: UUID(uuidString: "ad7d0eaf-0881-43eb-b12e-8dd169f9679c"),
        name: "Freestyle",
        imageKey: "images/exercises/jumprope/freestyle.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/freestyle.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeHighKnees = Exercise(
        id: UUID(uuidString: "dd2030b6-4173-4d58-a96a-df0d70616e78"),
        name: "High Knees",
        imageKey: "images/exercises/jumprope/high-knees.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/high-knees.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeFrontToBack = Exercise(
        id: UUID(uuidString: "0cd4b902-ba20-49e1-8b86-9241421c7094"),
        name: "Front to Back",
        imageKey: "images/exercises/jumprope/front-to-back.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/front-to-back.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let basicJump = Exercise(
        id: UUID(uuidString: "2f0d20cd-b769-48a6-ad82-b6688e89250f"),
        name: "Simple Jump",
        imageKey: "images/exercises/jumprope/simple-jump.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/simple-jump.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let jumpRopeSideToSide = Exercise(
        id: UUID(uuidString: "8da6732a-3b56-4df3-8a29-9c589396589b"),
        name: "Side to Side",
        imageKey: "images/exercises/jumprope/side-to-side.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/side-to-side.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let heavyRopeJumping = Exercise(
        id: UUID(uuidString: "6952f5d5-f560-4220-84ba-34b19dd2a9ad"),
        name: "Heavy rope jumping",
        imageKey: "images/exercises/jumprope/heavy-rope-jumping.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/heavy-rope-jumping.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let jumpingJacks = Exercise(
        id: UUID(uuidString: "5a3bbd69-07b5-4061-814a-f53feacf9cf8"),
        name: "Jumping jacks",
        imageKey: "images/exercises/bodyweight/jumping-jack.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/jumping-jack.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let pushUps = Exercise(
        id: UUID(uuidString: "42befa3b-8504-4afc-ab04-bb078a7f47ad"),
        name: "Push ups",
        imageKey: "images/exercises/bodyweight/push-up.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/push-up.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let pullUps = Exercise(
        id: UUID(uuidString: "13553e03-77bb-4a82-91ce-2a584cdf7953"),
        name: "Pull ups",
        imageKey: "images/exercises/bodyweight/pull-up.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/pull-up.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let shadowBoxing = Exercise(
        id: UUID(uuidString: "c992d22d-4255-4d3a-a119-b4abc767d04f"),
        name: "Shadow Boxing",
        imageKey: "images/exercises/bodyweight/shadow-boxing.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/shadow-boxing.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let boatToLowBoat = Exercise(
        id: UUID(uuidString: "708b18dd-1bc8-47d8-b933-9ec8b4c83246"),
        name: "Boat to low Boat",
        imageKey: "images/exercises/bodyweight/low-boat.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/low-boat.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let oneArmShoulderTouches = Exercise(
        id: UUID(uuidString: "61557ba6-5d66-4d6c-bcd9-4b9fb27eec6b"),
        name: "One Arm Shoulder Touches",
        imageKey: "images/exercises/bodyweight/plank.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg",
        level: .intermediate,
        muscles: [],
        steps: steps
    )
    
    static let bicycles = Exercise(
        id: UUID(uuidString: "9dd46b49-5f8b-4e81-a359-987051d07ac1"),
        name: "Bicycles",
        imageKey: "images/exercises/bodyweight/bicycles.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/bicycles.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let plank = Exercise(
        id: UUID(uuidString: "b5f45689-6010-48f7-a2a9-afc08e54c59a"),
        name: "High Plank",
        imageKey: "images/exercises/bodyweight/plank.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let lyingTStretch = Exercise(
        id: UUID(uuidString: "1086e4ec-b68f-4d53-81b2-20fd8e80713d"),
        name: "Lying T Stretch",
        imageKey: "images/exercises/bodyweight/lying-t-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/lying-t-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let figureFourStretch = Exercise(
        id: UUID(uuidString: "d37a8f11-b651-4f9c-a624-aed395ee9947"),
        name: "Figure Four Stretch",
        imageKey: "images/exercises/bodyweight/figure-four-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/figure-four-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let lyingHamstringStretch = Exercise(
        id: UUID(uuidString: "c2f76df3-f4a2-412d-9829-70f296ae41d9"),
        name: "Lying Hamstring Stretch",
        imageKey: "images/exercises/bodyweight/lying-hamstring-stretch.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/lying-hamstring-stretch.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let quadRockers = Exercise(
        id: UUID(uuidString: "230a03de-2d11-4b4b-a6d1-e837c7c8930c"),
        name: "Quad Rockers",
        imageKey: "images/exercises/bodyweight/quad-rockers.jpg",
        thumbnailKey: "thumbnails/exercises/bodyweight/quad-rockers.jpg",
        level: .beginner,
        muscles: [],
        steps: steps
    )
    
    static let recovery = Exercise(
        id: UUID(uuidString: "bc041ce4-d26f-4cae-b153-fe20a7a1dc10"),
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
        id: UUID(uuidString: "cb0c1d05-4112-40f5-af05-e5116b37e409"),
        name: "Cardio"
    )
    
    static let strength = Category(
        id: UUID(uuidString: "1f0856e9-ad52-42f5-a6d9-96bd2e014422"),
        name: "Strength"
    )
    
    static let boxing = Category(
        id: UUID(uuidString: "4362b5f2-a9fe-43ea-a78b-44887490f4d0"),
        name: "Boxing"
    )
}

private extension Workout {
    
    static let quickJumpropeBurn: (workout: Workout, sets: [ExerciseSet]) = {
        let workout = Workout(
            id: UUID(uuidString: "8cb277b5-4a33-4732-990f-b79d42f162c0"),
            name: "Quick Jumprope Burner",
            imageKey: "images/workouts/quick-jumprope-burner.jpg",
            thumbnailKey: "thumbnails/workouts/quick-jumprope-burner.jpg",
            categoryId: Category.cardio.id!,
            level: .beginner,
            muscles: [.calves]
        )
        
        let sets = [
            ExerciseSet(workout: workout, exercise: .basicJump, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .boxerStep, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .jumpRopeFrontToBack, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .jumpRopeHighKnees, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .basicJump, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .boxerStep, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .jumpRopeSideToSide, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .crissCross, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .basicJump, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .boxerStep, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .heavyRopeJumping, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .crissCross, duration: 60),
            .recovery(20, workout: workout),
            ExerciseSet(workout: workout, exercise: .lyingHamstringStretch, duration: 45),
            .recovery(10, workout: workout),
            ExerciseSet(workout: workout, exercise: .quadRockers, duration: 45),
            .recovery(10, workout: workout)
        ]
        
        return (
            workout: workout,
            sets: sets
        )
    }()

    static let fullBoxerRoutine: (workout: Workout, sets: [ExerciseSet]) = {
        
        let workout = Workout(
            id: UUID(uuidString: "5a7f5aad-d19c-4aa5-b484-8dd20ba199f4"),
            name: "Boxer Burner",
            imageKey: "images/workouts/complete-routine.jpg",
            thumbnailKey: "thumbnails/workouts/complete-routine.jpg",
            categoryId: Category.boxing.id!,
            level: .intermediate,
            muscles: [.calves]
        )
        
        let sets = [
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
        ]
        
        return (
            workout: workout,
            sets: sets
        )
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
