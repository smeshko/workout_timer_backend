import Vapor
import Fluent

protocol ListContentController: ContentController where Model: ListContentRepresentable {
    func list(_: Request) throws -> EventLoopFuture<[Model.ListItem]>
    func setupListRoute(routes: RoutesBuilder)
}

extension ListContentController {
    func list(_ req: Request) throws -> EventLoopFuture<[Model.ListItem]> {
        Model.query(on: req.db).all().map { $0.map(\.listContent) }
    }
    
    func setupListRoute(routes: RoutesBuilder) {
        routes.get(use: list)
    }
}
