import WorkoutTimerAPI
import Vapor

extension ExerciseGetDto: Content {}
extension ExerciseListDto: Content {}

extension Exercise: GetContentRepresentable {
    var getContent: ExerciseGetDto {
        ExerciseGetDto(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              steps: steps,
              muscles: muscles.map { $0.rawValue },
              level: level.rawValue,
              createdAt: createdAt,
              updatedAt: updatedAt
        )
    }
}

extension Exercise: ListContentRepresentable {
    var listContent: ExerciseListDto {
        ExerciseListDto(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              level: level.rawValue,
              createdAt: createdAt,
              updatedAt: updatedAt
        )
    }
}
