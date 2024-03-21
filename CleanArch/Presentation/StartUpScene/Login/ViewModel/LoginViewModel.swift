import Foundation

struct LoginViewModelActions {
    let showHomeScreen: () -> Void
}

protocol LoginViewModelInput {
    func onAuthorized()
}

protocol LoginViewModelOutput {
    
}


typealias LoginViewModel  = LoginViewModelInput & LoginViewModelOutput

final class LoginViewModelImpl: LoginViewModel {
    private let actions: LoginViewModelActions?
    
    init(actions: LoginViewModelActions) {
        self.actions = actions
    }
    
    // MARK: - Input
    func onAuthorized() {
        actions?.showHomeScreen()
    }
}
