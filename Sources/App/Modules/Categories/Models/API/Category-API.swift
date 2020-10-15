import Vapor
import WorkoutTimerAPI

extension CategoryListDto: Content {}
extension Category: ListContentRepresentable {
    var listContent: CategoryListDto {
        CategoryListDto(id: id!.uuidString,
              name: name,
              workouts: workouts.map(\.listContent),
              createdAt: createdAt,
              updatedAt: updatedAt
        )
    }
}
