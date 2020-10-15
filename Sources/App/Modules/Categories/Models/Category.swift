import Vapor
import Fluent

final class Category: Model {
    static let schema: String = "categories"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let createdAt: FieldKey = "createdAt"
        static let updatedAt: FieldKey = "updatedAt"
    }
    
    @ID var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Children(for: \.$category) var workouts: [Workout]
    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         name: String,
         createdAt: Date? = nil,
         updatedAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
