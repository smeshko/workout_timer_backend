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

extension Category: ListContentRepresentable {
    struct ListItem: Content {
        var id: String
        var name: String
        var workouts: [Workout]?
        
        init(model: Category) {
            self.id = model.id!.uuidString
            self.name = model.name
        }
    }
    
    var listContent: ListItem { .init(model: self) }
}
