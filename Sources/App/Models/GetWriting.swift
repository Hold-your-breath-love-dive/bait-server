import Foundation

struct GetWriting: Decodable {
    let id: Int
    let name, title, content: String
    let createDate: Date
    let modifyDate: Date?
    let image: String?
}
