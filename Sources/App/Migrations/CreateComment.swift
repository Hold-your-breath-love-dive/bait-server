import Fluent

struct CreateComment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("comments")
            .id()

    }

    func revert(on database: Database) async throws {
        try await database.schema("comments").delete()
    }
}
