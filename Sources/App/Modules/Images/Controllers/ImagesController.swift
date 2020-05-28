import struct Foundation.Data
import Vapor
import Fluent
import AWSS3

private extension Environment {
    static let awsAccessKey = Environment.get("AWS_KEY")!
    static let awsSecret = Environment.get("AWS_SECRET")!
    static let awsRegion = Environment.get("AWS_REGION")!
    static let awsBucket = Environment.get("AWS_BUCKET")!
}

extension Foundation.Data: ResponseEncodable {
    public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        request.eventLoop.makeSucceededFuture(Response(body: .init(data: self)))
    }
}

final class ImagesController {
    private let s3 = S3(accessKeyId: Environment.awsAccessKey,
                        secretAccessKey: Environment.awsSecret,
                        region: .init(rawValue: Environment.awsRegion))

    
    func getImage(req: Request) throws -> EventLoopFuture<Data> {
        let path = try req.query.get(String.self, at: "imageKey")
        let request = S3.GetObjectRequest(bucket: Environment.awsBucket, key: path)
        
        return s3.getObject(request).flatMapThrowing { output in
            guard let data = output.body?.asData() else { throw Abort(.notFound) }
            return data
        }
    }
}
