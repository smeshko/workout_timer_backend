import Vapor
import Fluent

struct WorkoutSeed: Codable {
    
}

public class Seed {
    var workouts: [Workout] = []
    var categories: [Category] = []
    var exercises: [Exercise] = []
    
    private var publicPath: String { "Public" }
    private var seedsPath: String { "assets/seeds" }
    private var workPath: String { DirectoryConfiguration.detect().workingDirectory }
    
    static let shared = Seed()
    private init() {}
    
    func prepareSeed(for env: Environment) {
        let exercisesFile = "exercises-seed-\(env.seedFile).json"
        let workoutsFile = "workouts-seed-\(env.seedFile).json"
        let categoriesFile = "categories-seed-\(env.seedFile).json"

        guard let exercises: [Exercise] = decodeSeed(exercisesFile) else { return }
        guard let workouts: [Workout] = decodeSeed(workoutsFile) else { return }
        guard let categories: [Category] = decodeSeed(categoriesFile) else { return }

        self.exercises = exercises
        self.workouts = workouts
        self.categories = categories
    }
    
    private func decodeSeed<T: Decodable>(_ file: String) -> T? {
        let url = URL(fileURLWithPath: workPath)
            .appendingPathComponent(publicPath)
            .appendingPathComponent(seedsPath)
            .appendingPathComponent(file)

        guard let jsonData = try? Data(contentsOf: url) else { return nil }
        guard let objects = try? JSONDecoder().decode(T.self, from: jsonData) else { return nil }
        
        return objects
    }
}

private extension Environment {
    var seedFile: String {
        switch self {
        case .production: return "production"
        default: return "staging"
        }
    }
}

struct SeedMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let seed = Seed.shared
        
        return database.eventLoop.flatten([
            seed.exercises.create(on: database),
            seed.categories.create(on: database),
            seed.workouts.create(on: database)
        ])
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            Exercise.query(on: database).delete(),
            Workout.query(on: database).delete(),
            Category.query(on: database).delete()
        ])
    }
}
