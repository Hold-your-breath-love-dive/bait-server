import Fluent
import Vapor

struct WritingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let writing = routes.grouped("writing")
        writing.get("list", use: getList)
        writing.on(.POST, body: .collect(maxSize: "500mb"), use: post)
        writing.group(":id") { writingID in
            writingID.get(use: getOne)
            writingID.put(use: put)
            writingID.delete(use: delete)
        }
    }
    
    func getOne(req: Request) async throws -> GetWriting {
        guard let id = req.parameters.get("id"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        if let writing = try await Writing
            .query(on: req.db)
            .filter(\.$idx == idInt)
            .first() {
            return try await writing.toDTO(on: req.db)
        } else {
            throw Abort(.notFound)
        }
    }

    func getList(req: Request) async throws -> [GetWriting] {
        let writing = try await Writing.query(on: req.db)
            .sort(\.$createDate, .descending)
            .all()
        var temp = [GetWriting]()
        for idx in 0..<writing.count {
            temp.append(try await writing[idx].toDTO(on: req.db))
        }
        return temp
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
        guard let id = req.parameters.get("id"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        if let writing = try await Writing
            .query(on: req.db)
            .filter(\.$idx == idInt)
            .first() {
            if param.password == writing.password {
                writing.name = param.name
                writing.title = param.title
                writing.content = param.content
                writing.image = param.image
                writing.modified = true
            } else {
                throw Abort(.badRequest)
            }
        } else {
            throw Abort(.notFound)
        }
        return .noContent
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        let param = try req.content.decode(DeleteWriting.self)
        guard let id = req.parameters.get("id"),
              let idInt = Int(id)
        else {
            throw Abort(.badRequest)
        }
        if let writing = try await Writing
            .query(on: req.db)
            .filter(\.$idx == idInt)
            .first() {
            if param.password == writing.password {
                try await writing.delete(on: req.db)
            } else {
                throw Abort(.badRequest)
            }
        } else {
            throw Abort(.notFound)
        }
        return .noContent
    }
}
