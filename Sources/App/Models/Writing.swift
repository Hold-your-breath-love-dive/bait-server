import Fluent
import Vapor

final class Writing: Model, Content {
    static let schema = "writings"
    
    @ID(key: .id)
    var id: UUID?

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
    
    @Timestamp(key: "modifyDate", on: .update, format: .iso8601)
    var modifyDate: Date?
    
    @OptionalField(key: "image")
    var image: String?

    init() { }

    init(id: UUID? = nil,
         name: String,
         password: String,
         title: String,
         content: String,
         createDate: Date?,
         modifyDate: Date?,
         image: String?) {
        self.id = id
        self.name = name
        self.password = password
        self.title = title
        self.content = content
        self.createDate = createDate
        self.modifyDate = modifyDate
        self.image = image
    }
}
