import WorkoutTimerAPI
import Vapor

extension ExerciseGetDto: Content {}
extension Exercise: GetContentRepresentable {
    var getContent: ExerciseGetDto {
        .init(id: id!.uuidString, name: name)
    }
}
