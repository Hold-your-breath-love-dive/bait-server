import Vapor

struct GetWriting: Content {
    let id: Int
    let name, title, content: String
    let createDate: Date
    let modified: Bool
    let image: String?
}
