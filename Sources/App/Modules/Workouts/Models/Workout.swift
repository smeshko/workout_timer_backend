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

extension Workout: Hashable, Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
