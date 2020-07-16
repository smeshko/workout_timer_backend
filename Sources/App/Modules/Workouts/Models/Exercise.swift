import Fluent
import Vapor
import WorkoutTimerAPI

enum Level: String, Codable {
    case beginner, intermediate, expert
}

final class Exercise: Model {
    static let schema = "exercises"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let workoutId: FieldKey = "workout_id"
        static var imageKey: FieldKey = "image_key"
        static let thumbnailKey: FieldKey = "thumbnail_key"
        static let level: FieldKey = "level"
        static let createdAt: FieldKey = "createdAt"
        static let updatedAt: FieldKey = "updatedAt"
        static let muscles: FieldKey = "muscles"
        static let steps: FieldKey = "steps"
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @Field(key: FieldKeys.thumbnailKey) var thumbnailKey: String?
    @Field(key: FieldKeys.level) var level: Level
    @Field(key: FieldKeys.muscles) var muscles: [String]
    @Field(key: FieldKeys.steps) var steps: [String]
    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         name: String,
         imageKey: String? = nil,
         thumbnailKey: String? = nil,
         level: Level = .beginner,
         muscles: [String] = [],
         steps: [String] = [],
         createdAt: Date? = nil,
         updatedAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.imageKey = imageKey
        self.thumbnailKey = thumbnailKey
        self.level = level
        self.muscles = muscles
        self.steps = steps
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
