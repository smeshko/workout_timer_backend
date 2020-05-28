import Fluent
import Vapor

struct ImagesModule: Module {
    var router: RouteCollection? { ImagesRouter() }
    
    var migrations: [Migration] { [] }
}
