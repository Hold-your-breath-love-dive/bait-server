import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let comment = routes.grouped("comment")
        comment.get("list", use: getList)
        comment.post(use: post)
        comment(":id").delete(use: delete)
    }
    
    func getList(req: Request) async throws -> [GetComment] {
        try await Comment.query(on: req.db)
            .sort(\.$createDate, .ascending)
            .all()
            .map { $0.toDTO() }
    }
}
