import SwiftUI

struct SampleSidebar: View {
    let samples: [ScriptSample]
    @Binding var selection: String?

    var body: some View {
        List(selection: $selection) {
            ForEach(samples) { sample in
                VStack(alignment: .leading, spacing: 4) {
                    Text(sample.title)
                        .font(.headline)
                    Text(sample.filename)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
                .tag(sample.filename)
            }
        }
        .navigationTitle("Samples")
    }
}
