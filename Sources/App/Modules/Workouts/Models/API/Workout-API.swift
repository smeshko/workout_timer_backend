import WorkoutTimerAPI
import Vapor

extension WorkoutListDto: Content {}
extension WorkoutGetDto: Content {}
extension Workout: ListContentRepresentable {
    var listContent: WorkoutListDto {
        WorkoutListDto(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              exerciseSets: exercises.map(\.listContent),
              level: level.rawValue,
              createdAt: createdAt,
              updatedAt: updatedAt
        )
    }
}

extension Workout: GetContentRepresentable {
    var getContent: WorkoutGetDto {
        WorkoutGetDto(
            id: id!.uuidString,
            name: name,
            imageKey: imageKey ?? "",
            thumbnailKey: thumbnailKey ?? "",
            exerciseSets: [],
            level: level.rawValue,
            muscles: muscles.map { $0.rawValue },
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
