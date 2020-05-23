import Vapor

struct WorkoutRouter: RouteCollection {
    let controller = WorkoutController()
    
    func boot(routes: RoutesBuilder) throws {
        let workoutsApi = routes.grouped("api")
        let workoutController = WorkoutController()
        workoutController.setupRoutes(routes: workoutsApi, on: "workouts")
    }
}
