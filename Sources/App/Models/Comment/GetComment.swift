import Vapor

struct GetComment: Content {
    let id: Int
    let name, content: String
    let createDate: Date
}
