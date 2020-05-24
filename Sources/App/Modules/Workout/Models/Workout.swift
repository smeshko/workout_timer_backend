import Vapor
import Fluent

final class Workout: Model {
    static let schema: String = "workouts"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let image: FieldKey = "image"
        static var imageKey: FieldKey = "image_key"
    }
    
    @ID var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.image) var image: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @Children(for: \.$workout) var exercises: [ExerciseSet]
    
    init() {}
    
    init(id: UUID? = nil, name: String, image: String, imageKey: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.imageKey = imageKey
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
        var exerciseSets: [ExerciseSet.ListItem]?
        
        init(model: Workout) {
            self.id = model.id!.uuidString
            self.name = model.name
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
