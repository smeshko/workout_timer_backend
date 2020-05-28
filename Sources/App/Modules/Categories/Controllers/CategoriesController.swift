import Vapor
import Fluent
import AWSS3

struct CategoriesController {
    func listPublicCategories(req: Request) -> EventLoopFuture<[Category.ListItem]> {
        Category.query(on: req.db).all().map { categories in
            categories.map(\.listContent)
        }
    }
}
