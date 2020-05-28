import Vapor
import Fluent

struct CategoryController {
    func listPublicCategories(req: Request) -> EventLoopFuture<[Category.ListItem]> {
        Category.query(on: req.db).all().map { categories in
            categories.map(\.listContent)
        }
    }
}
