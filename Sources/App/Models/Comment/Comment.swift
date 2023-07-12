import Fluent
import Vapor

final class Comment: Model, Content {
    static let schema = "comments"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "parentId")
    var parentId: Int
    
    @Field(key: "idx")
    var idx: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String

    @Field(key: "content")
    var content: String
    
    @Timestamp(key: "createDate", on: .create, format: .iso8601)
    var createDate: Date?

    init() { }

    init(parentId: Int,
         name: String,
         password: String,
         content: String) {
        self.parentId = parentId
        self.name = name
        self.password = password
        self.content = content
    }
    
    func toDTO() -> GetComment {
        return GetComment(id: self.idx ?? 0,
                          name: self.name,
                          content: self.content,
                          createDate: self.createDate ?? Date())
    }
}
