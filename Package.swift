// swift-tools-version:5.5.0

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
    name: "VEXA",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "Build", targets: ["Build"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "MainFeature", targets: ["MainFeature"]),
        .library(name: "Profile", targets: ["Profile"]),
        .library(name: "Resources", type: .dynamic, targets: ["Resources"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "CoreUI", targets: ["CoreUI"]),
        .library(name: "Analytics", targets: ["Analytics"]),
        .library(name: "Log", targets: ["Log"]),
        .library(name: "Services", targets: ["Services"])
    ],
    dependencies: [
        .package(name: "iPhoneNumberField",
                 url: "https://github.com/MojtabaHs/iPhoneNumberField.git",
                 from: "0.6.1"),
        .package(name: "KeychainAccess",
                 url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
                 from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Build",
            dependencies: [

            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                "Build",

            ]
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "SharedModels",
                "ApiClient",
                "Build",
                "MainFeature",
                "Profile",
                "UIApplicationClient",
                "CoreUI",
                "Services",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "MainFeature",
            dependencies: [
                "SharedModels",
                "Resources",
                "Analytics",
                "Log",
                "CoreUI",
                "Services",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(name: "Profile",
                dependencies: [
                    "SharedModels",
                    "CoreUI",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
               ),
        .target(name: "Resources",
                dependencies: [],
                resources: [
                    // Все ресурсы которые мы хотим использовать нужно явно указать
                    // Путь к ним относительный от Sources/имя_пакета/то_что_мы_указали
                    // Если указываем папку, поиск идет рекурсивно
                    //.process("Fonts")
                ]
               ),
        .target(name: "Core"),
        .target(name: "CoreUI",
                dependencies: [
                    "Resources",
                    "SharedModels"
                ]),
        .target(name: "Analytics", dependencies: [
            
        ]),
        .target(name: "Log"),
        .target(name: "Services")
    ]
)

package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.28.0")
])
package.products.append(contentsOf: [
    .library(name: "ApiClient", targets: ["ApiClient"]),
    .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
])
package.targets.append(contentsOf: [
    .target(
        name: "ApiClient",
        dependencies: [
            "SharedModels",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
    ),
    .target(
        name: "UIApplicationClient",
        dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
    ),
])
