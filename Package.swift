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
        .library(name: "AddContent", targets: ["AddContent"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Authorization", targets: ["Authorization"]),
        .library(name: "MainFeature", targets: ["MainFeature"]),
        .library(name: "ContentDetails", targets: ["ContentDetails"]),
        .library(name: "Profile", targets: ["Profile"]),
        .library(name: "Resources", type: .dynamic, targets: ["Resources"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "CoreUI", targets: ["CoreUI"]),
        .library(name: "Analytics", targets: ["Analytics"]),
        .library(name: "Log", targets: ["Log"]),
        .library(name: "Services", targets: ["Services"]),
        .library(name: "Protobuf", targets: ["Protobuf"]),
        .library(name: "UniversityProfile", targets: ["UniversityProfile"]),
        .library(name: "UniversitiesList", targets: ["UniversitiesList"]),
        .library(name: "Chat", targets: ["Chat"]),
        .library(name: "VEXAStreamChat", targets: ["VEXAStreamChat"]),
    ],
    dependencies: [
        .package(name: "iPhoneNumberField",
                 url: "https://github.com/MojtabaHs/iPhoneNumberField.git",
                 .upToNextMajor(from: "0.6.1")),
        .package(name: "KeychainAccess",
                 url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
                .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.2")),
        .package(url: "https://github.com/kean/Pulse", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/apple/swift-protobuf.git", .upToNextMajor(from: "1.19.0")),
        .package(url: "https://github.com/auth0/JWTDecode.swift.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/getstream/stream-chat-swiftui.git", .upToNextMajor(from: "4.19.0")),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", .upToNextMajor(from: "6.0.2"))
    ],
    targets: [
        .target(
            name: "AddContent",
            dependencies: [
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                "Protobuf"
            ]
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "SharedModels",
                "ApiClient",
                "MainFeature",
                "AddContent",
                "Profile",
                "Chat",
                "VEXAStreamChat",
                "UIApplicationClient",
                "CoreUI",
                "Services",
                "UniversitiesList",
                "Authorization",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "Authorization",
            dependencies: [
                "SharedModels",
                "CoreUI",
                "Services",
                "ApiClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
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
                "ApiClient",
                "ContentDetails",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "ContentDetails",
            dependencies: [
                "SharedModels",
                "Resources",
                "Analytics",
                "Log",
                "CoreUI",
                "Services",
                "ApiClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(name: "Profile",
                dependencies: [
                    "SharedModels",
                    "CoreUI",
                    "UniversityProfile",
                    "UniversitiesList",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
               ),
        .target(name: "Resources",
                dependencies: [],
                resources: [
                    // ?????? ?????????????? ?????????????? ???? ?????????? ???????????????????????? ?????????? ???????? ??????????????
                    // ???????? ?? ?????? ?????????????????????????? ???? Sources/??????_????????????/????_??????_????_??????????????
                    // ???????? ?????????????????? ??????????, ?????????? ???????? ????????????????????
                    //.process("Fonts")
                ]
               ),
        .target(name: "Core", dependencies: [
            "KeychainAccess",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]),
        .target(name: "CoreUI",
                dependencies: [
                    "Resources",
                    "SharedModels"
                ]),
        .target(name: "Analytics", dependencies: [
            
        ]),
        .target(name: "Log", dependencies: [
            "Core",
            .product(name: "Pulse", package: "Pulse"),
            .product(name: "PulseUI", package: "Pulse")
        ]),
        .target(name: "Services", dependencies: [
            "Core",
            "SharedModels",
            "Protobuf",
            "ApiClient",
            .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
            .product(name: "StreamChatSwiftUI", package: "stream-chat-swiftui")
        ]),
        .target(name: "Protobuf", dependencies: [
            .product(name: "SwiftProtobuf", package: "swift-protobuf")
        ]),
        .target(name: "UniversityProfile", dependencies: [
            "SharedModels",
            "CoreUI",
            "Log",
            "ApiClient",
            "EditProfileInfo",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
       ),
        .target(name: "EditProfileInfo", dependencies: [
            "SharedModels",
            "CoreUI",
            "Log",
            "ApiClient",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
       ),
        .target(name: "UniversitiesList", dependencies: [
            "SharedModels",
            "CoreUI",
            "Log",
            "UniversityProfile",
            "Services",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
       ),
        .target(name: "Chat",
                dependencies: [
                    "SharedModels",
                    "CoreUI",
                    "ApiClient",
                    "Services",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
        ),
        .target(name: "VEXAStreamChat",
                dependencies: [
                    "SharedModels",
                    "CoreUI",
                    "ApiClient",
                    "Services",
                    "Log",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "StreamChatSwiftUI", package: "stream-chat-swiftui")
                ]
        ),
    ]
)

package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.38.3"))
])
package.products.append(contentsOf: [
    .library(name: "ApiClient", targets: ["ApiClient"]),
    .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
])
package.targets.append(contentsOf: [
    .target(
        name: "ApiClient",
        dependencies: [
            "Analytics",
            "SharedModels",
            "Log",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "Alamofire", package: "alamofire"),
            "Protobuf",
            .product(name: "JWTDecode", package: "JWTDecode.swift")
        ]
    ),
    .target(
        name: "UIApplicationClient",
        dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
    ),
])
