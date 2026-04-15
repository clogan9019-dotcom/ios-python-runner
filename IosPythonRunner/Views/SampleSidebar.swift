import SwiftUI

struct SampleSidebar: View {
    let samples: [ScriptSample]
    let selectedFilename: String
    let selectionAction: (ScriptSample) -> Void

    var body: some View {
        List(samples) { sample in
            Button {
                selectionAction(sample)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(sample.title)
                        .font(.headline)
                    Text(sample.filename)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
            }
            .buttonStyle(.plain)
            .listRowBackground(
                sample.filename == selectedFilename ? Color.accentColor.opacity(0.12) : Color.clear
            )
        }
        .navigationTitle("Samples")
    }
}
