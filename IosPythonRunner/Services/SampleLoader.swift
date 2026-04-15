import Foundation

enum SampleLoader {
    static func loadSamples() -> [ScriptSample] {
        let bundled = sampleFilenames.compactMap(loadSample(named:))
        if bundled.isEmpty {
            return fallbackSamples
        }
        return bundled
    }

    private static let sampleFilenames = [
        "hello_runner.py",
        "math_demo.py",
        "jit_probe.py"
    ]

    private static func loadSample(named name: String) -> ScriptSample? {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: nil, subdirectory: "Samples"),
            let code = try? String(contentsOf: url)
        else {
            return nil
        }

        let title = name
            .replacingOccurrences(of: ".py", with: "")
            .replacingOccurrences(of: "_", with: " ")
            .capitalized

        return ScriptSample(title: title, filename: name, code: code)
    }

    private static let fallbackSamples: [ScriptSample] = [
        ScriptSample(
            title: "Hello Runner",
            filename: "hello_runner.py",
            code: """
            print("hello from ios python runner")
            """
        ),
        ScriptSample(
            title: "Math Demo",
            filename: "math_demo.py",
            code: """
            values = [n * n for n in range(1, 6)]
            print(values)
            print(sum(values))
            """
        ),
        ScriptSample(
            title: "JIT Probe",
            filename: "jit_probe.py",
            code: """
            import platform

            print("platform:", platform.platform())
            print("runtime check placeholder")
            """
        )
    ]
}
