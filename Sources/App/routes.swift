import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.group("writing") { writing in
        
        writing.get(":id") { req async -> GetWriting in
            let id = req.parameters.get("id")!
        }
        
        writing.get("list") { req async -> [GetWriting] in
            
        }
        
        writing.post { req -> EventLoopFuture<Response> in
            let data = try req.content.decode(PostWriting.self)
            return req.eventLoop.makeSucceededFuture(Response())
        }
        
        writing.patch(":id") { req -> EventLoopFuture<Response> in
            return req.eventLoop.makeSucceededFuture(Response())
        }
        
        writing.delete(":id") { req -> EventLoopFuture<Response> in
            return req.eventLoop.makeSucceededFuture(Response())
        }
    }
    try app.register(collection: WritingController())
}
