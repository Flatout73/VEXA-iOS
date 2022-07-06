//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.03.2022.
//

import Foundation
import Combine
import Core
import SharedModels
import ApiClient
import Protobuf

public class UserService {
    @KeychainStorage(key: "com.vexa.user")
    public var user: StudentModel?

    let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func fetchUser() async throws -> StudentModel {
        let request = ProfileRequest.me
        let student: Student = try await apiClient
            .send(request)

        let studentModel = StudentModel(id: student.user.id, firstName: student.user.firstName,
                                 secondName: student.user.lastName, email: student.user.email,
                                 dateOfBirth: Date(),
                                 country: student.currentCountry,
                                 nativeLanguage: student.nativeLanguage,
                                        image: URL(string: student.user.imageURL))
        self.user = studentModel
        return studentModel
    }
}
