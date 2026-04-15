import SwiftUI

struct CodeEditorPane: View {
    @Bindable var workspace: RunnerWorkspace

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                TextField("Script name", text: $workspace.filename)
                    .textFieldStyle(.roundedBorder)

                Picker("Mode", selection: $workspace.selectedMode) {
                    ForEach(RunnerMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 280)
            }

            TextEditor(text: $workspace.sourceCode)
                .font(.system(.body, design: .monospaced))
                .padding(12)
                .scrollContentBackground(.hidden)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.quaternary, lineWidth: 1)
                )
                .accessibilityIdentifier("pythonSourceEditor")
        }
    }
}
