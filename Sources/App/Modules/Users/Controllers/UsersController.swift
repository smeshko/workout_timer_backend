import Vapor
import Fluent

final class UsersController {
    
    func login(req: Request) throws -> EventLoopFuture<UserToken.GetContent> {
        guard let user = req.auth.get(User.self) else { throw Abort(.unauthorized) }

        let token = user.generateToken()
        return token.create(on: req.db).map { token.getContent }
    }
    
    func signup(req: Request) throws -> EventLoopFuture<UserToken.GetContent> {
        try User.CreateContent.validate(content: req)
        let content = try req.content.decode(User.CreateContent.self)
        
        guard content.password == content.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        
        let model = User()
        try model.create(content)
        
        return model.save(on: req.db).flatMap {
            let token = model.generateToken()
            return token.create(on: req.db).map { token.getContent }
        }
    }
    
    func logout(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        req.auth.logout(User.self)
        return req.eventLoop.makeSucceededFuture(.ok)
    }
}
