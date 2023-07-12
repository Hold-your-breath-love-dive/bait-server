import Vapor

struct PostWriting: Content {
    let name, password, title, content: String
    let image: String?
}
