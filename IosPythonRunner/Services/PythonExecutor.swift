import Foundation

protocol PythonExecutor {
    func run(script: String, filename: String) async throws -> RunResult
}

enum PythonExecutorError: LocalizedError {
    case runtimeUnavailable(details: String)

    var errorDescription: String? {
        switch self {
        case .runtimeUnavailable(let details):
            return details
        }
    }
}
