//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 28.06.2022.
//

import SwiftUI

public struct ShareSheet: UIViewControllerRepresentable {
    public typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    public let activityItems: [Any]
    public let applicationActivities: [UIActivity]? = nil
    public let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    public let callback: Callback? = nil

    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        controller.sheetPresentationController?.detents = [.medium(), .large()]
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
}
