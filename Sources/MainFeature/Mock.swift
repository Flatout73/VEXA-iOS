//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 23.02.2022.
//

import Foundation
import SharedModels

public extension Mock {
    static let longDesc = """
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.

"""

    static var discovery: [DiscoveryModel] {
        [
            DiscoveryModel(id: "0", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", desctription: "Test desc", image: URL(string: "https://i.stack.imgur.com/Xkh8T.png")),
            DiscoveryModel(id: "1", ambassador: "Pert First", universityName: "University of Tampa", videoName: "Dormatory", category: "Accomodation", desctription: longDesc, image: URL(string: "https://i.stack.imgur.com/EatSX.png")),
            DiscoveryModel(id: "2", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", desctription: longDesc, image: URL(string: "https://i.stack.imgur.com/EatSX.png")),
            DiscoveryModel(id: "3", ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", desctription: longDesc, image: URL(string: "https://i.stack.imgur.com/e54hT.png")),
        ]
    }
}
