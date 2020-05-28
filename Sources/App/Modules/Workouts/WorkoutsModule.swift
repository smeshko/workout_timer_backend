import Vapor
import Fluent

struct WorkoutsModule: Module {
    var router: RouteCollection? { WorkoutsRouter() }
    
    var migrations: [Migration] {
        [
            WorkoutsMigration_v1_0_0(),
            WorkoutsMigration_v1_1_0(),
            WorkoutsMigration_v1_2_0(),
            WorkoutsMigration_v1_3_0(),
            WorkoutsMigration_v1_4_0(),
            WorkoutsMigration_v1_5_0(),
        ]
    }
}

