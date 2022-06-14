// https://prafullkumar77.medium.com/swiftui-how-to-round-specific-corners-of-any-view-db707da66bde

import Foundation
import SwiftUI

public struct CornerRadiusShape: Shape {
    public let radius: CGFloat
    public let corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    public func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

public extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
