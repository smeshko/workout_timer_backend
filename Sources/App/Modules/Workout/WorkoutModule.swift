import Vapor
import Fluent

struct WorkoutModule: Module {
    var router: RouteCollection? { WorkoutRouter() }
    
    var migrations: [Migration] {
        [
            WorkoutsMigration_v1_0_0(),
            WorkoutsMigration_v1_1_0(),
            WorkoutsMigration_v1_2_0(),
        ]
    }
}

