import Foundation

struct PythonExecutionService {
    func run(
        script: String,
        filename: String,
        mode: RunnerMode
    ) async -> RunResult {
        let executor: PythonExecutor

        switch mode {
        case .compatible:
            executor = EmbeddedPythonExecutor()
        case .jitAssist:
            executor = JITAssistExecutor()
        }

        do {
            return try await executor.run(script: script, filename: filename)
        } catch {
            return RunResult(
                backendName: mode.runtimeName,
                stdout: "",
                stderr: error.localizedDescription,
                exitCode: 1
            )
        }
    }
}
