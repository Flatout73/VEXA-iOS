//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 23.02.2022.
//

import Foundation
import SharedModels

public extension Mock {
    static var discovery: [Discovery] {
        [
            Discovery(id: "0", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", image: URL(string: "https://i.stack.imgur.com/EatSX.png")),
            Discovery(id: "1", ambassador: "Pert First", universityName: "University of Tampa", videoName: "Dormatory", category: "Accomodation"),
            Discovery(id: "2", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content"),
            Discovery(id: "3", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content"),
        ]
    }
}
