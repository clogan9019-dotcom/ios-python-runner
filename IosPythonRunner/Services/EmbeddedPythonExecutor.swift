import Foundation

struct EmbeddedPythonExecutor: PythonExecutor {
    func run(script: String, filename: String) async throws -> RunResult {
        let trimmed = script.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return RunResult(
                backendName: "Embedded Python",
                stdout: "",
                stderr: "No script content provided.",
                exitCode: 1
            )
        }

        throw PythonExecutorError.runtimeUnavailable(
            details: """
            Embedded Python runtime is not linked yet.

            Next steps:
            1. Add Python.xcframework under Vendor/Python.
            2. Implement the bridge in EmbeddedPythonExecutor.
            3. Rebuild the app.

            Requested file: \(filename)
            """
        )
    }
}
