//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 14.06.2022.
//

import Foundation

public struct DiscoveryModel: Identifiable, Hashable {
    public struct Ambassador: Hashable {
        public let id: String
        public let name: String
        public let imageURL: URL?
        public let universityName: String

        public init(id: String, name: String, imageURL: URL?, universityName: String) {
            self.id = id
            self.name = name
            self.imageURL = imageURL
            self.universityName = universityName
        }
    }
    
    public let id: String
    public let ambassador: Ambassador
    public let universityName, videoName, category: String
    public let desctription: String
    public let videoURL: URL?
    public let image: URL?
    public let likesCount: Int
    public var isLiked: Bool

    public init(id: String, ambassador: Ambassador, universityName: String, videoName: String,
                category: String,
                desctription: String,
                likesCount: Int,
                isLiked: Bool = false,
                videoURL: URL? = nil,
                image: URL? = nil) {
        self.id = id
        self.ambassador = ambassador
        self.universityName = universityName
        self.videoName = videoName
        self.category = category
        self.desctription = desctription
        self.videoURL = videoURL
        self.image = image
        self.likesCount = likesCount
        self.isLiked = isLiked
    }
}

extension DiscoveryModel: Codable {
    
}

extension DiscoveryModel.Ambassador: Codable {

}
