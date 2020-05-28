import Vapor
import AWSS3

final class ImagesDriver {
    private let s3 = S3(accessKeyId: Environment.awsAccessKey,
                        secretAccessKey: Environment.awsSecret,
                        region: .init(rawValue: Environment.awsRegion))

    func getImage(req: Request) throws -> EventLoopFuture<Data> {
        let path = try req.query.get(String.self, at: "imageKey")
        
        if req.application.shouldUseLocalStorage {
            return req.eventLoop.makeSucceededFuture(try getLocalImage(at: path))
        } else {
            return try getRemoteImage(at: path)
        }
    }
}

private extension ImagesDriver {
    func getLocalImage(at path: String) throws -> Data {
        let workPath = DirectoryConfiguration.detect().workingDirectory
        let url = URL(fileURLWithPath: workPath)
            .appendingPathComponent("Public")
            .appendingPathComponent(path)

        return try Data(contentsOf: url)
    }
    
    func getRemoteImage(at path: String) throws -> EventLoopFuture<Data> {
        let request = S3.GetObjectRequest(bucket: Environment.awsBucket, key: path)

        return s3.getObject(request).flatMapThrowing { output in
            guard let data = output.body?.asData() else { throw Abort(.notFound) }
            return data
        }
    }
}

private extension Application {
    var shouldUseLocalStorage: Bool {
        switch environment {
        case .testing, .development: return true
        default: return false
        }
    }
}

private extension Environment {
    static let awsAccessKey = Environment.get("AWS_KEY") ?? ""
    static let awsSecret = Environment.get("AWS_SECRET") ?? ""
    static let awsRegion = Environment.get("AWS_REGION") ?? ""
    static let awsBucket = Environment.get("AWS_BUCKET") ?? ""
}

extension Foundation.Data: ResponseEncodable {
    public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        request.eventLoop.makeSucceededFuture(Response(body: .init(data: self)))
    }
}
