import Vapor

struct WorkoutRouter: RouteCollection {
    let controller = WorkoutController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("workouts", use: controller.getWorkouts)
    }
}
