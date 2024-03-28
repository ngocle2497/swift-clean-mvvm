import Foundation

struct RegisterViewModelActions {
    let showLoginScreen: () -> Void
}

protocol RegisterViewModelInput {
    func goBack() -> Void
}

protocol RegisterViewModelOutput {
    
}

final class RegisterViewModel: ViewModel, RegisterViewModelInput, RegisterViewModelOutput {
    private let actions: RegisterViewModelActions?
    
    init(actions: RegisterViewModelActions?) {
        self.actions = actions
    }
    
}

extension RegisterViewModel {
    // MARK: - Input
    func goBack() {
        actions?.showLoginScreen()
    }
}
