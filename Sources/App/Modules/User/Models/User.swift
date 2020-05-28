import Vapor
import Fluent

final class User: Model, Authenticatable {
    static let schema = "users"
    
    struct FieldKeys {
        static let email: FieldKey = "email"
        static let passwordHash: FieldKey = "password_hash"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.email) var email: String
    @Field(key: FieldKeys.passwordHash) var passwordHash: String
    
    init() { }
    
    init(id: User.IDValue? = nil, email: String, passwordHash: String) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
    }
}

extension User {
    func generateToken() -> UserToken {
        .init(value: [UInt8].random(count: 128).base64, userId: self.id!)
    }
}

extension User: GetContentRepresentable {
    
    struct GetContent: Content {
        var id: String
        var email: String
        
        init(model: User) {
            self.id = model.id!.uuidString
            self.email = model.email
        }
    }
    
    var getContent: GetContent { .init(model: self) }
}

extension User: CreateContentRepresentable {
    
    struct CreateContent: ValidatableContent {
        var email: String
        var password: String
        var confirmPassword: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("email", as: String.self, is: .email)
            validations.add("password", as: String.self, is: .count(3...8))
        }
    }
    
    func create(_ content: CreateContent) throws {
        self.email = content.email
        self.passwordHash = try Bcrypt.hash(content.password)
    }
}
