# SwiftArg

## A stupid simple argument parser for Swift.

`SwiftArg` is a command line argument parser with virtually no learning curve. It relies only on
the Swift standard library.

### Example

```swift
import SwiftArg

let parser = Parser()

// Add long options.
parser.addOption(names: ["version"])

// Add short options.
parser.addOption(names: ["f"])
parser.addOption(names: ["r"])

// Long and short options are automatically differentiated between.
parser.addOption(names: ["help", "h"])

// Positional arguments are added to the last option raised, with a limit you define.
// Options can be assigned to with either syntax: `--output=foo.txt` or `--output foo.txt`.
parser.addOption(names: ["output", "o"], maxValueCount: 1)

// So if the arguments were "foo --help -ru -o foo.txt bar --blah"...
parser.parse(arguments: CommandLine.arguments)

// ...then all of the following expressions would be true.
parser.executableArgument == "foo"

parser.hasRaisedOption(named: "h")
parser.hasRaisedOption(named: "r")
parser.hasRaisedOption(named: "help")

!parser.hasRaisedOption(named: "f")

parser.hasRaisedOption(named: "output")
parser.valuesOfOption(named: "output") == ["foo.txt"]

parser.unrecognizedArguments == ["-u", "bar", "--blah"]
```

This covers the entire interface. Check the Xcode Quick Help if you still want more information on
individual functions.

### Importing

To import `SwiftArg` into your project, just add it to your package dependencies in
`Package.swift` and as a target dependency to any target that will `import SwiftArg`.

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .package(url: "https://github.com/jaredmpayne/SwiftArg.git", from: "1.0")
    ]
    products: [
        .library(name: "YourPackage", targets: ["YourPackage"])
    ],
    targets: [
        .target(name: "YourPackage", dependencies: ["SwiftArg"]),
        .testTarget(name: "YourPackageTests", dependencies: ["YourPackage"])
    ]
)
```
