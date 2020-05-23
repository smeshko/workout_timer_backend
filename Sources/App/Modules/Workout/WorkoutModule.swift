import Vapor
import Fluent

struct WorkoutModule: Module {
//    var router: RouteCollection? { BlogRouter() }
    
    var migrations: [Migration] {
        [
            WorkoutsMigration_v1_0_0(),
        ]
    }
}

