import Foundation

struct ScriptSample: Identifiable, Hashable {
    let title: String
    let filename: String
    let code: String

    var id: String { filename }

    init(
        title: String,
        filename: String,
        code: String
    ) {
        self.title = title
        self.filename = filename
        self.code = code
    }
}
