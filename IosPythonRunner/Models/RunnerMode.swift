import Foundation

enum RunnerMode: String, CaseIterable, Codable, Identifiable {
    case compatible
    case jitAssist

    var id: String { rawValue }

    var title: String {
        switch self {
        case .compatible:
            return "Compatible"
        case .jitAssist:
            return "JIT Assist"
        }
    }

    var summary: String {
        switch self {
        case .compatible:
            return "Uses the normal embedded Python path intended to work on standard iOS setups."
        case .jitAssist:
            return "Reserved for sideload or specialized backends that can provide faster execution."
        }
    }

    var runtimeName: String {
        switch self {
        case .compatible:
            return "Embedded Python"
        case .jitAssist:
            return "JIT Assist"
        }
    }
}
