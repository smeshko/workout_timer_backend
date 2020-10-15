import Vapor
import Fluent

struct CategoriesController {
    func listPublicCategories(req: Request) -> EventLoopFuture<[Category.ListItem]> {
        Category.query(on: req.db).with(\.$workouts) { $0.with(\.$exercises) { $0.with(\.$exercise) } }.all().map { categories in
            categories.map(\.listContent)
        }
    }
}
