import Vapor

struct UserRouter: RouteCollection {
    let controller = UserController()
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api", "users")
        
        api.grouped(UserCredentialsAuthenticator())
            .post("login", use: controller.login)
        api.post("signup", use: controller.signup)
        api.post("logout", use: controller.logout)
    }
}
