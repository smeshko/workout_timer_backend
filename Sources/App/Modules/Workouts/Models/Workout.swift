import Vapor
import Fluent

final class Workout: Model {
    static let schema: String = "workouts"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let image: FieldKey = "image"
        static let imageKey: FieldKey = "image_key"
        static let thumbnailKey: FieldKey = "thumbnail_key"
        static let category: FieldKey = "category_id"
    }
    
    @ID var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.thumbnailKey) var thumbnailKey: String?
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @OptionalParent(key: FieldKeys.category) var category: Category?
    @Children(for: \.$workout) var exercises: [ExerciseSet]
    
    init() {}
    
    init(id: UUID? = nil, name: String, imageKey: String? = nil, thumbnailKey: String? = nil, categoryId: UUID? = nil) {
        self.id = id
        self.name = name
        self.imageKey = imageKey
        self.thumbnailKey = thumbnailKey
        self.$category.id = categoryId
    }
}

extension Workout: APIRepresentable {
    struct ListItem: Content {
        var id: String
        var name: String
        
        init(model: Workout) {
            self.id = model.id!.uuidString
            self.name = model.name
        }
    }
    
    struct GetContent: Content {
        var id: String
        var name: String
        var imageKey: String?
        var thumbnailKey: String?
        var exerciseSets: [ExerciseSet.ListItem]?
        
        init(model: Workout) {
            self.id = model.id!.uuidString
            self.name = model.name
            self.imageKey = model.imageKey
            self.thumbnailKey = model.thumbnailKey
        }
    }
    
    struct CreateContent: ValidatableContent {
        var name: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("name", as: String.self, is: !.empty)
        }
    }

    struct UpdateContent: ValidatableContent {
        var name: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("name", as: String.self, is: !.empty)
        }
    }
    
    struct PatchContent: ValidatableContent {
        var name: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("name", as: String.self, is: !.empty)
        }
    }

    var listContent: ListItem {
        .init(model: self)
    }
    
    var getContent: GetContent {
        .init(model: self)
    }
    
    func create(_ content: CreateContent) throws {
        self.name = content.name
    }

    func update(_ content: UpdateContent) throws {
        self.name = content.name
    }
    
    func patch(_ content: PatchContent) throws {
        self.name = content.name
    }
}
