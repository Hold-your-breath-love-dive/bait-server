import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: CommentController())
    try app.register(collection: WritingController())
}
