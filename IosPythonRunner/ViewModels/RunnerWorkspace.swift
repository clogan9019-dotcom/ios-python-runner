import Foundation
import Observation

@Observable
final class RunnerWorkspace {
    var scriptTitle: String
    var filename: String
    var sourceCode: String
    var output: String
    var selectedSampleFilename: String?
    var selectedMode: RunnerMode
    var isRunning: Bool
    var samples: [ScriptSample]
    var lastBackendName: String?

    private let service = PythonExecutionService()

    init() {
        let loadedSamples = SampleLoader.loadSamples()
        let initial = loadedSamples.first ?? ScriptSample(
            title: "New Script",
            filename: "main.py",
            code: "print(\"hello\")"
        )

        scriptTitle = initial.title
        filename = initial.filename
        sourceCode = initial.code
        output = "Ready."
        selectedSampleFilename = initial.filename
        selectedMode = .compatible
        isRunning = false
        samples = loadedSamples
        lastBackendName = nil
    }

    func applySelection(filename: String?) {
        guard
            let filename,
            let sample = samples.first(where: { $0.filename == filename })
        else {
            return
        }

        scriptTitle = sample.title
        filename = sample.filename
        sourceCode = sample.code
        output = "Loaded \(sample.filename)"
    }

    func clearOutput() {
        output = ""
    }

    @MainActor
    func runCurrentScript() async {
        guard !isRunning else { return }

        isRunning = true
        output = "Running \(filename)..."

        let result = await service.run(
            script: sourceCode,
            filename: filename,
            mode: selectedMode
        )

        lastBackendName = result.backendName
        output = Self.composeOutput(from: result)
        isRunning = false
    }

    private static func composeOutput(from result: RunResult) -> String {
        var lines: [String] = []
        lines.append("Backend: \(result.backendName)")
        lines.append("Exit Code: \(result.exitCode)")

        if !result.stdout.isEmpty {
            lines.append("")
            lines.append("STDOUT")
            lines.append(result.stdout)
        }

        if !result.stderr.isEmpty {
            lines.append("")
            lines.append("STDERR")
            lines.append(result.stderr)
        }

        return lines.joined(separator: "\n")
    }
}
