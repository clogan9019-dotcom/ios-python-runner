import SwiftUI

struct OutputPane: View {
    let output: String
    let backendName: String?
    let isRunning: Bool
    let clearAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Console")
                        .font(.headline)
                    Text(statusText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Clear", action: clearAction)
                    .buttonStyle(.bordered)
            }

            ScrollView {
                Text(output.isEmpty ? "No output yet." : output)
                    .font(.system(.footnote, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .padding(14)
            .frame(minHeight: 220, maxHeight: .infinity, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(uiColor: .secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.quaternary, lineWidth: 1)
            )
        }
    }

    private var statusText: String {
        if isRunning {
            return "Execution in progress"
        }

        if let backendName {
            return "Last backend: \(backendName)"
        }

        return "Awaiting execution"
    }
}
