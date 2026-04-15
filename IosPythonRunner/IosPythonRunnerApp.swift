import SwiftUI

@main
struct IosPythonRunnerApp: App {
    @State private var workspace = RunnerWorkspace()

    var body: some Scene {
        WindowGroup {
            ContentView(workspace: workspace)
        }
    }
}
