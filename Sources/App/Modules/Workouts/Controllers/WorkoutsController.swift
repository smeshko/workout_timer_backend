import Vapor
import Fluent

struct WorkoutsController: GetContentController, ListContentController {
    typealias Model = Workout
    
    func get(_ req: Request) throws -> EventLoopFuture<Workout.GetContent> {
        try find(req).flatMap { workout in
            ExerciseSet.query(on: req.db)
                .filter(\.$workout.$id == workout.id!)
                .with(\.$exercise)
                .all()
                .map { sets in
                    var details = workout.getContent
                    details.exerciseSets = sets.map(\.listContent)
                    return details
            }
        }
    }
}
