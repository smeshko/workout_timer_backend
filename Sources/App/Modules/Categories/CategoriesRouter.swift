import Vapor

struct CategoriesRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let categoryController = CategoriesController()
        let categoriesGroup = api.grouped("categories")
        
        categoriesGroup.get("public", use: categoryController.listPublicCategories)
    }
}
