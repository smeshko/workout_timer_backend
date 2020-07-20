import WorkoutTimerAPI
import Vapor

extension WorkoutListDto: Content {}
extension WorkoutGetDto: Content {}
extension Workout: ListContentRepresentable {
    var listContent: WorkoutListDto {
        .init(id: id!.uuidString,
              name: name,
              imageKey: imageKey ?? "",
              thumbnailKey: thumbnailKey ?? "",
              exerciseSets: exercises.map(\.listContent),
              level: level.rawValue
        )
    }
}

extension Workout: GetContentRepresentable {
    var getContent: WorkoutGetDto {
        .init(
            id: id!.uuidString,
            name: name,
            imageKey: imageKey ?? "",
            thumbnailKey: thumbnailKey ?? "",
            exerciseSets: [],
            level: level.rawValue,
            muscles: muscles.map { $0.rawValue }
        )
    }
}
