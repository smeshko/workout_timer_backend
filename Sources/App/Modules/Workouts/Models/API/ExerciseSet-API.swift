import WorkoutTimerAPI
import Vapor

extension ExerciseSetListDto: Content {}
extension ExerciseSet: ListContentRepresentable {
    var listContent: ExerciseSetListDto {
        ExerciseSetListDto(id: id!.uuidString, duration: duration, exercise: exercise.getContent, type: type.rawValue)
    }
}
