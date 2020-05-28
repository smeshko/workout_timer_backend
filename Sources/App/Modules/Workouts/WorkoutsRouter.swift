import Vapor

struct WorkoutsRouter: RouteCollection {    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let workoutController = WorkoutsController()
        workoutController.setupRoutes(routes: api, on: "workouts")
    }
}
