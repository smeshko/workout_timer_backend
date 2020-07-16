import Vapor
import Fluent

struct WorkoutsModule: Module {
    
    var router: RouteCollection? { WorkoutsRouter() }
    
    var migrations: [Migration] {
        [
            WorkoutsMigration_v2_0_0(),
        ]
    }
    
    func seeds(_ env: Environment) -> [SeedMigration] {
        [
            SeedMigration_v1_0_0(environment: env)
        ]
    }
}
