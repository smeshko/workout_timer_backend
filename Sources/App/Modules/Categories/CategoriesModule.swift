import Fluent
import Vapor

struct CategoriesModule: Module {
    var router: RouteCollection? { CategoriesRouter() }
    
    var migrations: [Migration] { [] }
}
