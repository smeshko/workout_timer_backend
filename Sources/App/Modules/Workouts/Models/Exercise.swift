import Fluent
import Vapor
import WorkoutTimerAPI

final class Exercise: Model {
    static let schema = "exercises"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let image: FieldKey = "image"
        static let workoutId: FieldKey = "workout_id"
        static var imageKey: FieldKey = "image_key"
        static let thumbnailKey: FieldKey = "thumbnail_key"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @Field(key: FieldKeys.thumbnailKey) var thumbnailKey: String?

    init() {}
    
    init(id: UUID? = nil, name: String, imageKey: String? = nil, thumbnailKey: String? = nil) {
        self.id = id
        self.name = name
        self.imageKey = imageKey
        self.thumbnailKey = thumbnailKey
    }
}
