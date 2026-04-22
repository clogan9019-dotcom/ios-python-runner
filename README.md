# iOS Python Runner

`iOS Python Runner` is a SwiftUI app scaffold for editing and running Python scripts on iOS with two execution profiles:

- `Compatible`: the normal embedded-Python path intended for stock iOS behavior.
- `JIT Assist`: an optional higher-performance mode for sideload or specialized environments where a JIT-capable runtime or helper is available.

## What This Repo Includes

- A real Xcode project scaffold.
- A SwiftUI editor-style interface for writing and running scripts.
- Example bundled Python scripts.
- A runtime abstraction so the app can support multiple backends cleanly.
- A placeholder embedded runtime bridge that compiles today and tells you exactly what is missing.

## Important Reality Check

This scaffold does **not** ship a Python runtime binary in the repo yet.

For local execution on iOS, Python must be embedded into the app bundle. The current project is wired so you can add that later without restructuring the app:

1. Add a Python XCFramework under `Vendor/Python/Python.xcframework`.
2. Add a bridging layer or wrapper module that calls into the embedded interpreter.
3. Replace the placeholder implementation in `IosPythonRunner/Services/EmbeddedPythonExecutor.swift`.

The `JIT Assist` mode in this scaffold is intentionally treated as optional. The app UI exposes it as a capability surface, but the current implementation falls back to the same embedded execution pathway unless you provide a specialized backend.

## Suggested Next Steps

1. Open `IosPythonRunner.xcodeproj` in Xcode on macOS.
2. Set your signing team and bundle identifier.
3. Add your Python runtime artifacts under `Vendor/Python`.
4. Wire the bridge in `IosPythonRunner/Services/EmbeddedPythonExecutor.swift`.
5. If you want a sideload-specific faster backend, extend `JITAssistExecutor`.

## GitHub Actions (.ipa)

This repo includes a workflow that can build a device `.ipa` as a GitHub Actions artifact:

- Workflow: `.github/workflows/ios-ipa.yml`
- Requires signing secrets (iOS will not install an unsigned `.ipa`):
  - `IOS_P12_BASE64`: base64 of your signing certificate `.p12`
  - `IOS_P12_PASSWORD`: password for the `.p12`
  - `IOS_MOBILEPROVISION_BASE64`: base64 of your `.mobileprovision`
  - `IOS_KEYCHAIN_PASSWORD`: any password used to create a temporary CI keychain

Optional:
- Repo variable `IOS_EXPORT_METHOD` (defaults to `development`). Other common values: `ad-hoc`, `app-store`.

## Project Structure

- `IosPythonRunner.xcodeproj`: Xcode project
- `IosPythonRunner/`: app source
- `IosPythonRunner/Samples/`: bundled sample scripts
- `Vendor/Python/`: placeholder location for embedded Python runtime artifacts
