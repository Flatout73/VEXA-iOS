//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 14.06.2022.
//

import Foundation

public struct Discovery: Identifiable, Equatable {
    public let id: String
    public let ambassador, universityName, videoName, category: String
    public let videoURL: URL?
    public let image: URL?

    public init(id: String, ambassador: String, universityName: String, videoName: String,
                category: String,
                videoURL: URL? = nil,
                image: URL? = nil) {
        self.id = id
        self.ambassador = ambassador
        self.universityName = universityName
        self.videoName = videoName
        self.category = category
        self.videoURL = videoURL
        self.image = image
    }
}
