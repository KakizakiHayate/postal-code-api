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
        .library(name: "AddressResultFeature", targets: ["AddressResultFeature"]),
        .library(name: "ZipCloudAPIClient", targets: ["ZipCloudAPIClient"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "1.0.0"),
            .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "1.0.0"),
            .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.2.0"),
            .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
            .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.0.2"),
            .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.0.0"),
            .package(url: "https://github.com/pointfreeco/swiftui-navigation", from: "1.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Entity"),
        .target(
            name: "Home",
            dependencies: [
                "AddressResultFeature",
                "Entity",
                "ZipCloudAPIClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "AddressResultFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "ZipCloudAPIClient",
            dependencies: [
                "Entity",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        )
    ]
)
