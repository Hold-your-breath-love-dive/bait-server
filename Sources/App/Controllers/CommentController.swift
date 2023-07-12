import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let comment = routes.grouped("comment")
        comment.get(":parentId", use: getList)
        comment.post(use: post)
        comment.delete(":id", use: delete)
    }
    
    func getList(req: Request) async throws -> [GetComment] {
        guard let id = req.parameters.get("parentId"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        return try await Comment
            .query(on: req.db)
            .filter(\.$parentId == idInt)
            .sort(\.$createDate, .ascending)
            .all()
            .map { $0.toDTO() }
    }
    
    func post(req: Request) async throws -> HTTPStatus {
        
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        
    }
}
