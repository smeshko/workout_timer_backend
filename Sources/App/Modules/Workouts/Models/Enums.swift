import Foundation

enum Level: String, Codable {
    case beginner, intermediate, expert
}

enum ExerciseType: String, Codable {
    case warmup, cooldown, workout,  rest
}

enum Muscle: String, Codable {
    case calves
}
