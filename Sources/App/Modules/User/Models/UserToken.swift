import Vapor
import Fluent

final class UserToken: Model {
    static let schema = "user_tokens"
    
    struct FieldKeys {
        static let value: FieldKey = "value"
        static let userId: FieldKey = "user_id"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.value) var value: String
    @Parent(key: FieldKeys.userId) var user: User
    
    init() { }
    
    init(id: UserToken.IDValue? = nil, value: String, userId: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userId
    }
}

extension UserToken: GetContentRepresentable {
    struct GetContent: Content { var id: String
        var value: String
        init(model: UserToken) {
            self.id = model.id!.uuidString
            self.value = model.value
        }
    }
    
    var getContent: GetContent { .init(model: self) }
}
