# Vendor Python Runtime

Place your embedded Python runtime artifacts here.

Expected long-term shape:

- `Python.xcframework`
- any thin wrapper headers or Objective-C bridge files you use to call into Python

The app currently compiles without these files because the runtime bridge is stubbed behind a Swift abstraction.
