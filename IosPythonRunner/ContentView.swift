import SwiftUI

struct ContentView: View {
    @Bindable var workspace: RunnerWorkspace

    var body: some View {
        NavigationSplitView {
            SampleSidebar(
                samples: workspace.samples,
                selection: $workspace.selectedSampleFilename
            )
            .onChange(of: workspace.selectedSampleFilename) { _, newValue in
                workspace.applySelection(filename: newValue)
            }
        } detail: {
            detailContent
                .navigationTitle("iOS Python Runner")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            Task {
                                await workspace.runCurrentScript()
                            }
                        } label: {
                            if workspace.isRunning {
                                ProgressView()
                            } else {
                                Label("Run", systemImage: "play.fill")
                            }
                        }
                        .disabled(workspace.isRunning)
                        .accessibilityIdentifier("runScriptButton")
                    }
                }
        }
    }

    private var detailContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerCard
                CodeEditorPane(workspace: workspace)
                    .frame(minHeight: 320)
                OutputPane(
                    output: workspace.output,
                    backendName: workspace.lastBackendName,
                    isRunning: workspace.isRunning,
                    clearAction: workspace.clearOutput
                )
            }
            .padding(20)
            .frame(maxWidth: 1100, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(backgroundGradient)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Run Python on iPhone or iPad")
                .font(.system(size: 30, weight: .bold, design: .rounded))

            Text("This scaffold keeps the stock iOS execution path separate from any sideload-specific JIT strategy, so the app can support both without pretending they are the same thing.")
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                modeBadge(for: .compatible)
                modeBadge(for: .jitAssist)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .strokeBorder(.white.opacity(0.18), lineWidth: 1)
        )
    }

    private func modeBadge(for mode: RunnerMode) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(mode.title)
                .font(.subheadline.weight(.semibold))
            Text(mode.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(workspace.selectedMode == mode ? Color.accentColor.opacity(0.14) : Color.black.opacity(0.06))
        )
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.95, green: 0.93, blue: 0.89),
                Color(red: 0.86, green: 0.92, blue: 0.96),
                Color(red: 0.98, green: 0.97, blue: 0.94)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView(workspace: RunnerWorkspace())
}
