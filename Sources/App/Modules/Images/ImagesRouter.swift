import Vapor

struct ImagesRouter: RouteCollection {
    let controller = ImagesController()
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let imageController = ImagesController()
        let imagesGroup = api.grouped("images")
        
        imagesGroup.get("", use: imageController.getImage)
    }
}
