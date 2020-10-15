import Fluent
import Vapor

struct CategoriesModule: Module {
    var router: RouteCollection? { CategoriesRouter() }
    
    var migrations: [Migration] { [
        CategoriesMigration_v1_0_0()
    ] }
}
