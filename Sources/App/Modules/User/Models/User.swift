import Vapor
import Fluent

final class User: Model, Authenticatable {
    static let schema = "user_users"

    struct FieldKeys {
        static let email: FieldKey = "email"
        static let password: FieldKey = "password"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.email) var email: String
    @Field(key: FieldKeys.password) var password: String
    
    init() { }
    
    init(id: User.IDValue? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}
