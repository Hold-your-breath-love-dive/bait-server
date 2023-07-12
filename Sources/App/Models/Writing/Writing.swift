import Fluent
import Vapor

final class Writing: Model, Content {
    static let schema = "writings"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "idx")
    var idx: Int?

    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    @Timestamp(key: "createDate", on: .create, format: .iso8601)
    var createDate: Date?
    
    @Field(key: "modified")
    var modified: Bool
    
    @OptionalField(key: "image")
    var image: String?

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
    
    func toDTO(on: Database) async throws -> GetWriting {
        let commentCount = try await Comment
            .query(on: on)
            .filter(\.$parentId == self.idx ?? 0)
            .all()
            .count
        return GetWriting(id: self.idx ?? 0,
                          commentCount: commentCount,
                          name: self.name,
                          title: self.title,
                          content: self.content,
                          createDate: self.createDate ?? Date(),
                          modified: self.modified,
                          image: self.image)
    }
}
