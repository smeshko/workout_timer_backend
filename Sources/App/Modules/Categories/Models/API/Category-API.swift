import Vapor
import WorkoutTimerAPI

extension CategoryListDto: Content {}
extension Category: ListContentRepresentable {
    var listContent: CategoryListDto {
        .init(id: id!.uuidString, name: name, workouts: workouts.map(\.listContent))
    }
}
