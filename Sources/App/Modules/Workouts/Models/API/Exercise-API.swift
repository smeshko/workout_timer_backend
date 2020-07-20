import WorkoutTimerAPI
import Vapor

extension ExerciseGetDto: Content {}
extension ExerciseListDto: Content {}

extension Exercise: GetContentRepresentable {
    var getContent: ExerciseGetDto {
        .init(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              steps: steps,
              muscles: muscles.map { $0.rawValue },
              level: level.rawValue
        )
    }
}

extension Exercise: ListContentRepresentable {
    var listContent: ExerciseListDto {
        .init(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              level: level.rawValue
        )
    }
}
