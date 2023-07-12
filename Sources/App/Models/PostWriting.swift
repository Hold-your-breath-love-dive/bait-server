import Vapor

struct PostWriting: Content {
    let name, password, title, content: String
    let image: String?
    
    func toModel() -> Writing {
        Writing(name: self.name,
                password: self.password,
                title: self.title,
                content: self.content,
                image: self.image)
    }
}
