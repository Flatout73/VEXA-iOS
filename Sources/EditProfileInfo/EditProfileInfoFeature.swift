import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import ApiClient
import Core
import Protobuf

public struct EditProfileInfoState: Equatable {
    public var alert: AlertState<EditProfileInfoAction.AlertAction>?

    @BindableState
    var userFirstName: String = ""
    @BindableState
    var userSecondName: String = ""
    @BindableState
    var email: String = ""
    @BindableState
    var dateOfBirthhday: String = ""
    @BindableState
    var nativeLanguage: String = ""

    public var isLoading = false

    public var user: StudentModel

    public init(user: StudentModel) {
        self.user = user
    }
}

public enum EditProfileInfoAction: BindableAction, Equatable {
    case binding(BindingAction<EditProfileInfoState>)

    case alert(AlertAction)
    case showError(String)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct EditProfileInfoEnvironment {
    let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

let EditProfileInfoReducerCore = Reducer<EditProfileInfoState, EditProfileInfoAction, EditProfileInfoEnvironment> { state, action, environment in
    switch action {
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    case .binding(_):
        return .none
    }

    return .none
}
