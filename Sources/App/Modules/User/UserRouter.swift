import Vapor

struct UserRouter: RouteCollection {
    let controller = UserController()
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api", "user")
        
        api.grouped(UserCredentialsAuthenticator()).post("login", use: controller.login)
    }
}
