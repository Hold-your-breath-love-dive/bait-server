import Fluent

struct CreateWriting: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("writings")
            .id()
            .field("idx", .custom("serial"))
            .field("name", .string, .required)
            .field("password", .string, .required)
            .field("title", .string, .required)
            .field("content", .string, .required)
            .field("createDate", .string, .required)
            .field("modified", .bool)
            .field("image", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("writings").delete()
    }
}
