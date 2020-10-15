import struct Foundation.Data
import Vapor
import Fluent

final class ImagesController {
    let storage = ImagesDriver()
    
    func getImage(req: Request) throws -> EventLoopFuture<Data> {
        try storage.getImage(req: req)
    }
}
