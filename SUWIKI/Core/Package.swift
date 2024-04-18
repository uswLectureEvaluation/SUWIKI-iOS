// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(
            name: "DIContainer", targets: ["DIContainer"]),
        .library(name: "Keychain", targets: ["Keychain"]),
        .library(name: "Network", targets: ["Network"]),
        .library(name: "State", targets: ["State"]),
        .library(name: "FirebaseManager", targets: ["FirebaseManager"]),
        .library(name: "CoreDataManager", targets: ["CoreDataManager"]),
        .library(name: "CustomElliotable", targets: ["CustomElliotable"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git",
                 .upToNextMajor(from: "5.9.1")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git",
                 .upToNextMajor(from: "10.4.0")),

    ],
    targets: [
        .target(
            name: "DIContainer",
            path: "DIContainer"
        ),
        .target(
            name: "Keychain",
            path: "Keychain"
        ),
        .target(
            name: "Network",
            dependencies: [.product(name: "Alamofire", package: "Alamofire")],
            path: "Network"),
        .target(
            name: "State",
            path: "State"
        ),
        .target(
            name: "FirebaseManager",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk")
            ],
            path: "FirebaseManager"
        ),
        .target(
            name: "CoreDataManager",
            path: "CoreDataManager"
        ),
        .target(
            name: "CustomElliotable",
            path: "CustomElliotable"
        ),
//        .testTarget(
//            name: "NetworkTest",
//            dependencies: ["Network"]),
    ]
)
