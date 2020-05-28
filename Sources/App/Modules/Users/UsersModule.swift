import Fluent
import Vapor

struct UsersModule: Module {
    var router: RouteCollection? { UsersRouter() }
    
    var migrations: [Migration] {
        [
            UserMigration_v1_0_0(),
            UserMigration_v1_1_0(),
        ]
    }
}
