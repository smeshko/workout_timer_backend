import Vapor
import Fluent

final class Workout: Model {
    static let schema: String = "workouts"
    
    struct FieldKeys {
        static let name: FieldKey = "name"
        static let imageKey: FieldKey = "image_key"
        static let thumbnailKey: FieldKey = "thumbnail_key"
        static let category: FieldKey = "category_id"
        static let level: FieldKey = "level"
        static let createdAt: FieldKey = "createdAt"
        static let updatedAt: FieldKey = "updatedAt"
        static let muscles: FieldKey = "muscles"
    }
    
    @ID var id: UUID?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.thumbnailKey) var thumbnailKey: String?
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @OptionalParent(key: FieldKeys.category) var category: Category?
    @Children(for: \.$workout) var exercises: [ExerciseSet]
    @Field(key: FieldKeys.level) var level: Level
    @Field(key: FieldKeys.muscles) var muscles: [String]
    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}
    
    init(id: UUID? = nil,
         name: String,
         imageKey: String? = nil,
         thumbnailKey: String? = nil,
         categoryId: UUID? = nil,
         level: Level = .beginner,
         muscles: [String] = [],
         createdAt: Date? = nil,
         updatedAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.imageKey = imageKey
        self.thumbnailKey = thumbnailKey
        self.$category.id = categoryId
        self.level = level
        self.muscles = muscles
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension Workout: Hashable, Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
