// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "llvm-swift-installer",
    products: [.executable(name: "llvm-swift-installer", targets: ["installer"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-system", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "installer",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SystemPackage", package: "swift-system")
            ]
        )
    ]
)
