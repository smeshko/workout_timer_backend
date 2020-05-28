import Fluent
import Vapor

final class ExerciseSet: Model {
    static let schema = "exercise_sets"
    
    struct FieldKeys {
        static let duration: FieldKey = "duration"
        static let exericseId: FieldKey = "exercise_id"
        static let workoutId: FieldKey = "workout_id"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.duration) var duration: Double
    @Parent(key: FieldKeys.exericseId) var exercise: Exercise
    @Parent(key: FieldKeys.workoutId) var workout: Workout

    init() {}
    
    init(id: UUID? = nil, duration: Double, exerciseId: UUID, workoutId: UUID) {
        self.id = id
        self.duration = duration
        self.$exercise.id = exerciseId
        self.$workout.id = workoutId
    }
}

extension ExerciseSet: ListContentRepresentable {
    struct ListItem: Content {
        var id: String
        var duration: Double
        var exercise: Exercise.GetContent?
        
        init(model: ExerciseSet) {
            self.id = model.id!.uuidString
            self.duration = model.duration
            self.exercise = model.exercise.getContent
        }
    }
    
    var listContent: ListItem {
        .init(model: self)
    }
}
