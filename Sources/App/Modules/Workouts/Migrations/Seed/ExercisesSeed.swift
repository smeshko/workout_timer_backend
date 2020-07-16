import Foundation

extension ExerciseSet {
    static func crissCross(_ duration: Double, workoutId: UUID) -> ExerciseSet {
        ExerciseSet(
//            id: UUID(uuidString: "b43ddbe1-17da-47eb-853b-21264dfc4252"),
            id: UUID(),
            duration: duration,
            exerciseId: Exercise.crissCross.id!,
            workoutId: workoutId
        )
    }
    
    static func boxerStep(_ duration: Double, workoutId: UUID) -> ExerciseSet {
        ExerciseSet(
//            id: UUID(uuidString: "c611074e-2b63-4f56-9ed5-553d76cef1cd"),
            id: UUID(),
            duration: duration,
            exerciseId: Exercise.boxerStep.id!,
            workoutId: workoutId
        )
    }

    static func doubleUnder(_ duration: Double, workoutId: UUID) -> ExerciseSet {
        ExerciseSet(
//            id: UUID(uuidString: "188ac3b7-910c-4785-aecf-ad7716376f40"),
            id: UUID(),
            duration: duration,
            exerciseId: Exercise.doubleUnder.id!,
            workoutId: workoutId
        )
    }
}

extension Category {
    static let boxing = Category(
//        id: UUID(uuidString: "ef241987-231b-431c-9b94-9534dee40150"),
        id: UUID(),
        name: "Boxing"
    )
}

extension Workout {
    static let boxerBurner: (workout: Workout, sets: [ExerciseSet]) = {
        let id = UUID()
        return (workout:
            Workout(
                id: id,
                name: "Boxer Burner",
                imageKey: "images/workouts/boxer-burner.jpg",
                thumbnailKey: "thumbnails/workouts/boxer-burner.jpg",
                categoryId: Category.boxing.id!,
                level: .intermediate,
                muscles: ["Calves"]
            ),
         sets: [
            ExerciseSet.crissCross(30, workoutId: id),
            ExerciseSet.boxerStep(60, workoutId: id),
            ExerciseSet.doubleUnder(30, workoutId: id),
            ExerciseSet.boxerStep(60, workoutId: id),
            ExerciseSet.crissCross(30, workoutId: id),
            ExerciseSet.boxerStep(60, workoutId: id),
            ExerciseSet.doubleUnder(30, workoutId: id),
        ])
    }()
}

extension Exercise {
    
    static let crissCross = Exercise(
//        id: UUID(uuidString: "2a676146-f8ef-4ae1-b2d9-2dc6f1bc0f9b"),
        id: UUID(),
        name: "Criss Cross",
        imageKey: "images/exercises/jumprope/criss-cross.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/criss-cross.jpg",
        level: .intermediate,
        muscles: ["Calves"]
    )
    
    static let boxerStep = Exercise(
//        id: UUID(uuidString: "3588ddb4-0403-4fe7-b159-bcdbf31dbe22"),
        id: UUID(),
        name: "Boxer steps",
        imageKey: "images/exercises/jumprope/boxer-step.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/boxer-step.jpg",
        level: .beginner,
        muscles: ["Calves"]
    )
    
    static let doubleUnder = Exercise(
//        id: UUID(uuidString: "0209e827-9d83-4065-8ff1-a77665c1ec4c"),
        id: UUID(),
        name: "Double Unders",
        imageKey: "images/exercises/jumprope/double-unders.jpg",
        thumbnailKey: "thumbnails/exercises/jumprope/double-unders.jpg",
        level: .expert,
        muscles: ["Calves"]
    )

//    static let crissCross = Exercise(name: "Criss Cross", imageKey: "images/exercises/jumprope/criss-cross.jpg", thumbnailKey: "thumbnails/exercises/jumprope/criss-cross.jpg")
    
//    static let doubleUnder = Exercise(name: "Double Unders", imageKey: "images/exercises/jumprope/double-unders.jpg", thumbnailKey: "thumbnails/exercises/jumprope/double-unders.jpg")
    
//    static let boxerStep = Exercise(name: "Boxer steps", imageKey: "images/exercises/jumprope/boxer-step.jpg", thumbnailKey: "thumbnails/exercises/jumprope/boxer-step.jpg")
    
    static let runInPlace = Exercise(name: "Run in Place", imageKey: "images/exercises/jumprope/run-in-place.jpg", thumbnailKey: "thumbnails/exercises/jumprope/run-in-place.jpg")
    
    static let freestyle = Exercise(name: "Freestyle", imageKey: "images/exercises/jumprope/freestyle.jpg", thumbnailKey: "thumbnails/exercises/jumprope/freestyle.jpg")
    
    static let highKnees = Exercise(name: "High Knees", imageKey: "images/exercises/jumprope/high-knees.jpg", thumbnailKey: "thumbnails/exercises/jumprope/high-knees.jpg")
    
    static let frontToBack = Exercise(name: "Front to Back", imageKey: "images/exercises/jumprope/front-to-back.jpg", thumbnailKey: "thumbnails/exercises/jumprope/front-to-back.jpg")
    
    static let simpleJump = Exercise(name: "Simple Jump", imageKey: "images/exercises/jumprope/simple-jump.jpg", thumbnailKey: "thumbnails/exercises/jumprope/simple-jump.jpg")
    
    static let sideToSide = Exercise(name: "Side to Side", imageKey: "images/exercises/jumprope/side-to-side.jpg", thumbnailKey: "thumbnails/exercises/jumprope/side-to-side.jpg")
    
    static let heavyRopeJumping = Exercise(name: "Heavy rope jumping", imageKey: "images/exercises/jumprope/heavy-rope-jumping.jpg", thumbnailKey: "thumbnails/exercises/jumprope/heavy-rope-jumping.jpg")
    
    static let jumpingJacks = Exercise(name: "Jumping jacks", imageKey: "images/exercises/bodyweight/jumping-jack.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/jumping-jack.jpg")
    
    static let pushUps = Exercise(name: "Push ups", imageKey: "images/exercises/bodyweight/push-up.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/push-up.jpg")
    
    static let pullUps = Exercise(name: "Pull ups", imageKey: "images/exercises/bodyweight/pull-up.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/pull-up.jpg")
    
    static let shadowBoxing = Exercise(name: "Shadow Boxing", imageKey: "images/exercises/bodyweight/shadow-boxing.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/shadow-boxing.jpg")
    
    static let boatToLowBoat = Exercise(name: "Boat to low Boat", imageKey: "images/exercises/bodyweight/low-boat.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/low-boat.jpg")
    
    static let oneArmShoulderTouches = Exercise(name: "One Arm Shoulder Touches", imageKey: "images/exercises/bodyweight/plank.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg")
    
    static let bicycles = Exercise(name: "Bicycles", imageKey: "images/exercises/bodyweight/bicycles.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/bicycles.jpg")
    
    static let plank = Exercise(name: "High Plank", imageKey: "images/exercises/bodyweight/plank.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/plank.jpg")
    
    static let lyingTStretch = Exercise(name: "Lying T Stretch", imageKey: "images/exercises/bodyweight/lying-t-stretch.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/lying-t-stretch.jpg")
    
    static let figureFourStretch = Exercise(name: "Figure Four Stretch", imageKey: "images/exercises/bodyweight/figure-four-stretch.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/figure-four-stretch.jpg")
    
    static let lyingHamstringStretch = Exercise(name: "Lying Hamstring Stretch", imageKey: "images/exercises/bodyweight/lying-hamstring-stretch.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/lying-hamstring-stretch.jpg")

    static let quadRockers = Exercise(name: "Quad Rockers", imageKey: "images/exercises/bodyweight/quad-rockers.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/quad-rockers.jpg")
    
    static let recovery = Exercise(name: "Recovery", imageKey: "images/exercises/bodyweight/recovery.jpg", thumbnailKey: "thumbnails/exercises/bodyweight/recovery.jpg")
}
