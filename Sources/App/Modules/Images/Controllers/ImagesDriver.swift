import Vapor
import AWSS3

final class ImagesDriver {

    private let client: AWSClient
    private let s3: S3
    
    init() {
        client = AWSClient(
            credentialProvider: .static(accessKeyId: Environment.awsAccessKey, secretAccessKey: Environment.awsSecret),
            httpClientProvider: .createNew
        )
        
        s3 = S3(
            client: client,
            region: .init(rawValue: Environment.awsRegion
            )
        )
    }
    
    deinit {
        do {
            try client.syncShutdown()
        } catch {}
    }
    
    func getImage(req: Request) throws -> EventLoopFuture<Data> {
        let path = try req.query.get(String.self, at: "imageKey")
        
        if req.application.shouldUseLocalStorage {
            return req.eventLoop.makeSucceededFuture(try getLocalImage(at: path)).unwrap(or: Abort(.notFound))
        } else {
            return try getRemoteImage(at: path)
        }
    }
}

private extension ImagesDriver {
    
    var publicPath: String { "Public" }
    var placeholderPath: String { "images/placeholder.png" }
    
    var placeholderUrl: URL {
        URL(fileURLWithPath: workPath)
            .appendingPathComponent(publicPath)
            .appendingPathComponent(placeholderPath)
    }
    
    var workPath: String {
        DirectoryConfiguration.detect().workingDirectory
    }
    
    func getLocalImage(at path: String) throws -> Data? {
        let url = URL(fileURLWithPath: workPath)
            .appendingPathComponent(publicPath)
            .appendingPathComponent(path)
        
        if FileManager.default.fileExists(atPath: url.path) {
            return try? Data(contentsOf: url)
        } else {
            return try? Data(contentsOf: placeholderUrl)
        }
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
