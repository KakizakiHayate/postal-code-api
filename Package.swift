// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PostalCodeAPI",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Entity", targets: ["Entity"]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "AddressResultFeature", targets: ["AddressResultFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.5.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Entity"),
        .target(
            name: "Home",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(name: "AppFeature"),
        .target(
            name: "AddressResultFeature",
            dependencies: [
//                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
    ]
)