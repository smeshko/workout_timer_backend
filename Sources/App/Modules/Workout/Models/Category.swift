import Vapor
import Fluent

final class Category: Model {
    static let schema: String = "categories"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
    }
    
    @ID var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Children(for: \.$category) var workouts: [Workout]
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
