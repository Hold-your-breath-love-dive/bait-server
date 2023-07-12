import Vapor

struct PostComment: Content {
    let name, password, content: String
}
