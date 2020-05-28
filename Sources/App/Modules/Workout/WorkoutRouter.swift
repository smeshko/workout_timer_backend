import Vapor

struct WorkoutRouter: RouteCollection {
    let controller = WorkoutsController()
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let workoutController = WorkoutsController()
        workoutController.setupRoutes(routes: api, on: "workouts")
        
        let categoryController = CategoriesController()
        let categoriesGroup = api.grouped("categories")
        categoriesGroup.get("public", use: categoryController.listPublicCategories)
        
        let imageController = ImagesController()
        let imagesGroup = api.grouped("images")
        imagesGroup.get("", use: imageController.getImage)
    }
}
