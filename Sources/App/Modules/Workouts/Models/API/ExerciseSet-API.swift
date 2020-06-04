import WorkoutTimerAPI
import Vapor

extension ExerciseSetListDto: Content {}
extension ExerciseSet: ListContentRepresentable {
    var listContent: ExerciseSetListDto {
        .init(id: id!.uuidString, duration: duration, exercise: exercise.getContent)
    }
}
