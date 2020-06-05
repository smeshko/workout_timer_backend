import Vapor
import Fluent

struct WorkoutsController: GetContentController, ListContentController {
    typealias Model = Workout
    
    func list(_ req: Request) throws -> EventLoopFuture<[Workout.ListItem]> {
        Workout.query(on: req.db).with(\.$exercises).all().flatMap { workouts in
            workouts.map { workout in
                self.fetchSets(for: workout, on: req.db).map { sets in
                    var list = workout.listContent
                    list.exerciseSets = sets.map(\.listContent)
                    return list
                }
            }
            .flatten(on: req.eventLoop)
        }
    }
    
    
    func get(_ req: Request) throws -> EventLoopFuture<Workout.GetContent> {
        try find(req).flatMap { workout in
            self.fetchSets(for: workout, on: req.db)
                .map { sets in
                    var details = workout.getContent
                    details.exerciseSets = sets.map(\.listContent)
                    return details
            }
        }
    }
    
    private func fetchSets(for workout: Workout, on db: Database) -> EventLoopFuture<[ExerciseSet]> {
        ExerciseSet.query(on: db)
            .filter(\.$workout.$id == workout.id!)
            .with(\.$exercise)
            .all()
    }
}
