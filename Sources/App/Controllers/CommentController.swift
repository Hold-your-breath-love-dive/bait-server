import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let comment = routes.grouped("comment")
        comment.get("list", use: getList)
        comment.post(use: post)
        comment(":id").delete(use: delete)
    }
}
