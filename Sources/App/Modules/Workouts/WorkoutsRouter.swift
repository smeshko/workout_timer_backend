import Vapor

struct WorkoutsRouter: RouteCollection {    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api", "workout")
        let workoutController = WorkoutsController()
        
        workoutController.setupGetRoute(routes: api)
        workoutController.setupListRoute(routes: api)
    }
}
