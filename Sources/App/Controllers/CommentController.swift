import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let writing = routes.grouped("writing")
        writing.get("list", use: getList)
        writing.post(use: post)
        writing.group(":id") { writingID in
            writingID.get(use: getOne)
            writingID.put(use: put)
            writingID.delete(use: delete)
        }
    }
}
