import Vapor

struct WorkoutRouter: RouteCollection {
    let controller = WorkoutController()
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let workoutController = WorkoutController()
        workoutController.setupRoutes(routes: api, on: "workouts")
        
        let categoryController = CategoryController()
        let categoriesGroup = api.grouped("categories")
        categoriesGroup.get("public", use: categoryController.listPublicCategories)
    }
}
