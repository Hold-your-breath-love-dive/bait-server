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
        let param = try req.content.decode(PostComment.self)
        guard let id = req.parameters.get("id"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        let writing = Comment(parentId: idInt,
                              name: param.name,
                              password: param.password,
                              content: param.content)
        try await writing.save(on: req.db)
        return .noContent
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        let param = try req.content.decode(PostComment.self)
        guard let id = req.parameters.get("id"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        if let comment = try await Comment
            .query(on: req.db)
            .filter(\.$idx == idInt)
            .first() {
            if param.password == comment.password {
                try await comment.delete(on: req.db)
            } else {
                throw Abort(.badRequest)
            }
        } else {
            throw Abort(.notFound)
        }
        return .noContent
    }
}
