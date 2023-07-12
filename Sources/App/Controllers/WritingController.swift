import Fluent
import Vapor

struct WritingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let writing = routes.grouped("writing")
        writing.get(use: getList)
        writing.post(use: post)
        writing.group(":id") { writingID in
            writingID.get(use: getOne)
            writingID.put(use: put)
            writingID.delete(use: delete)
        }
    }
    
    func getOne(req: Request) async throws -> GetWriting {
        guard let writing = try await Writing.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return writing.toDTO()
    }
    
    func getList(req: Request) async throws -> [GetWriting] {
        try await Writing.query(on: req.db)
            .sort(\.$createDate, .descending)
            .all()
            .map { $0.toDTO() }
    }

    func post(req: Request) async throws -> HTTPStatus {
        let param = try req.content.decode(PostWriting.self)
        let writing = Writing(name: param.name,
                              password: param.password,
                              title: param.title,
                              content: param.content,
                              image: param.image)
        try await writing.save(on: req.db)
        return .noContent
    }

    func put(req: Request) async throws -> HTTPStatus {
        let param = try req.content.decode(PostWriting.self)
        guard let writing = try await Writing.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        if param.password == writing.password {
            writing.name = param.name
            writing.title = param.title
            writing.content = param.content
            writing.image = param.image
        } else {
            throw Abort(.badRequest)
        }
        return .noContent
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        let param = try req.content.decode(PostWriting.self)
        guard let writing = try await Writing.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        if param.password == writing.password {
            try await writing.delete(on: req.db)
        } else {
            throw Abort(.badRequest)
        }
        return .noContent
    }
}
