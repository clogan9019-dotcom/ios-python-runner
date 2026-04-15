import Foundation

struct ScriptSample: Identifiable, Hashable {
    let id: UUID
    let title: String
    let filename: String
    let code: String

    init(
        id: UUID = UUID(),
        title: String,
        filename: String,
        code: String
    ) {
        self.id = id
        self.title = title
        self.filename = filename
        self.code = code
    }
}
