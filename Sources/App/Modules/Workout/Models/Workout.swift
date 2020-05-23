import Vapor
import Fluent

final class Workout: Model, Content {
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
