import Vapor
import Fluent

struct WorkoutController {
    func getWorkouts(req: Request) -> EventLoopFuture<[Workout]> {
        Workout.query(on: req.db).all()
    }
}
