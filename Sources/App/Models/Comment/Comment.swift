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

    init(name: String,
         password: String,
         title: String,
         content: String,
         modified: Bool = false,
         image: String?) {
        self.name = name
        self.password = password
        self.title = title
        self.content = content
        self.modified = modified
        self.image = image
    }
    
    func toDTO() -> GetWriting {
        return GetWriting(id: self.idx ?? 0,
                          name: self.name,
                          title: self.title,
                          content: self.content,
                          createDate: self.createDate ?? Date(),
                          modified: self.modified,
                          image: self.image)
    }
}
