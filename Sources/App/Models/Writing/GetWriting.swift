import Vapor

struct GetWriting: Content {
    let id, commentCount: Int
    let name, title, content: String
    let createDate: Date
    let modified: Bool
    let image: String?
}
