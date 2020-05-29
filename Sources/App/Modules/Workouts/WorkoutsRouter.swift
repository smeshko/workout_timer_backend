import Vapor

struct WorkoutsRouter: RouteCollection {    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api", "workouts")
        let workoutController = WorkoutsController()
        
        workoutController.setupGetRoute(routes: api)
        workoutController.setupListRoute(routes: api)
    }
}
