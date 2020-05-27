import Vapor
import Fluent

final class UserController {
    func login(req: Request) throws -> EventLoopFuture<UserToken.GetContent> {
        guard let user = req.auth.get(User.self) else { throw Abort(.unauthorized) }
        
        let tokenValue = [UInt8].random(count: 16).base64
        let token = UserToken(value: tokenValue, userId: user.id!)
        
        return token.create(on: req.db).map { token.getContent }
    }
}
