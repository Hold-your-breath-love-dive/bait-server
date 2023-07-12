import Fluent
import Vapor

struct WritingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let writings = routes.grouped("writings")
        writings.get(use: index)
        writings.post(use: create)
        writings.group(":writingID") { writing in
            writing.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Writing] {
        try await Writing.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Writing {
        let writing = try req.content.decode(Writing.self)
        try await writing.save(on: req.db)
        return writing
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let writing = try await Writing.find(req.parameters.get("writingID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await writing.delete(on: req.db)
        return .noContent
    }
}
