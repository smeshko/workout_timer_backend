import Foundation
import Vapor
import Fluent

struct SeedMigration_v1_0_0: SeedMigration {
    
    let seed: Seed
    
    init(environment: Environment) {
        switch environment {
        case .production:
            seed = ProductionDatabaseSeed_v1()
        default:
            seed = StagingDatabaseSeed_v1()
        }
        
    }
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        seed.prepare(on: database)
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        seed.revert(on: database)
    }
}
