import Fluent
import Vapor

enum ExerciseType: String, Codable {
    case warmup, cooldown, workout,  rest
}

final class ExerciseSet: Model {
    static let schema = "exercise_sets"
    
    struct FieldKeys {
        static let duration: FieldKey = "duration"
        static let exericseId: FieldKey = "exercise_id"
        static let workoutId: FieldKey = "workout_id"
        static let exerciseType: FieldKey = "exercise_type"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.duration) var duration: Double
    @Parent(key: FieldKeys.exericseId) var exercise: Exercise
    @Parent(key: FieldKeys.workoutId) var workout: Workout
    @Field(key: FieldKeys.exerciseType) var type: ExerciseType

    init() {}
    
    init(id: UUID? = nil, duration: Double, exerciseId: UUID, workoutId: UUID, type: ExerciseType = .workout) {
        self.id = id
        self.duration = duration
        self.$exercise.id = exerciseId
        self.$workout.id = workoutId
        self.type = type
    }
}
