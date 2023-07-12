import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.group("writing") { users in
        app.get(":id") { req async -> Writing in
            let id = req.parameters.get("id")!
        }
    }
    try app.register(collection: WritingController())
}
