import Foundation

struct JITAssistExecutor: PythonExecutor {
    private let fallback = EmbeddedPythonExecutor()

    func run(script: String, filename: String) async throws -> RunResult {
        do {
            return try await fallback.run(script: script, filename: filename)
        } catch {
            throw PythonExecutorError.runtimeUnavailable(
                details: """
                JIT Assist mode is exposed in the UI, but no specialized JIT-capable backend is configured yet.

                The app currently falls back to the embedded runtime path, which is also not linked.

                Under a sideload-specific setup, replace JITAssistExecutor with your accelerated backend.
                """
            )
        }
    }
}
