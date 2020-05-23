import Fluent
import Vapor

final class Exercise: Model {
    static let schema = "exercises"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let image: FieldKey = "image"
        static let workoutId: FieldKey = "workout_id"
        static var imageKey: FieldKey = "image_key"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.image) var image: String
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    
    init() {}
    
    init(id: UUID? = nil, name: String, image: String, imageKey: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.imageKey = imageKey
    }
}
