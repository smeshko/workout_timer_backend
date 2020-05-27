import Fluent
import Vapor

struct UserModule: Module {
    var router: RouteCollection? { UserRouter() }
    
    var migrations: [Migration] {
        [
            UserMigration_v1_0_0(),
            UserMigration_v1_1_0(),
        ]
    }
}
