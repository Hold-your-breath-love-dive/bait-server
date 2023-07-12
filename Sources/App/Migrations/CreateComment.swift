import Fluent

struct CreateComment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("comments")
            .id()
            .field("parentId", .int, .required)
            .field("idx", .custom("serial"))
            .field("name", .string, .required)
            .field("password", .string, .required)
            .field("content", .string, .required)
            .field("createDate", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("comments").delete()
    }
}
