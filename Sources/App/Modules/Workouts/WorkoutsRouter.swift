import Vapor

struct WorkoutsRouter: RouteCollection {    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let workoutController = WorkoutsController()
        workoutController.setupRoutes(routes: api, on: "workouts")
        
        
        api.get("exercises") { (req: Request) in
            Exercise.query(on: req.db).all().map { $0.map(\.getContent) }
        }
    }
}
