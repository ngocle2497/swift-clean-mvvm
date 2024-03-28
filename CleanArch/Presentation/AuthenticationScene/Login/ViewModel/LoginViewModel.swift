import Foundation
import RxSwift
import RxCocoa

struct LoginViewModelActions {
    let showAuthorizedScreen: (Bool) -> Void
    let showRegisterScreen: () -> Void
}

protocol LoginViewModelInput {
    func onAuthorized()
}

protocol LoginViewModelOutput {
    var emailText: BehaviorRelay<String?> { get }
    var passwordText: BehaviorRelay<String?> { get }
    var errorEmail: Observable<String?> { get }
    var errorPassword: Observable<String?> { get }
}


typealias LoginViewModelType  = LoginViewModelInput & LoginViewModelOutput

final class LoginViewModel: ViewModel, LoginViewModelType {
    internal let emailText = BehaviorRelay<String?>(value: "")
    internal let passwordText = BehaviorRelay<String?>(value: "")
    
    private let actions: LoginViewModelActions?
    private let userUserCase: UserUseCase
    
    init(actions: LoginViewModelActions, userUseCase: UserUseCase) {
        self.actions = actions
        self.userUserCase = userUseCase
    }
    
    
}

extension LoginViewModel {
    internal var errorEmail: Observable<String?> {
        return emailText.map({value in
            guard let text = value else {
                return S10n.Login.Email.required
            }
            if text.count <= 0 {
                return S10n.Login.Email.required
            }
            if text.validateEmail() {
                return nil
            }else {
                return S10n.Login.Email.invalid
            }
        })
    }
    
    internal var errorPassword: Observable<String?> {
        return passwordText.map({value in
            guard let text = value else {
                return S10n.Login.Password.required
            }
            if text.count <= 0 {
                return S10n.Login.Password.required
            }
            if text.validatePassword() {
                return nil
            }else {
                return S10n.Login.Password.invalid
            }
        })
    }
    
}

// MARK: - Input
extension LoginViewModel {
    func onAuthorized() {
        if emailText.value == "ngocle@gmail.com" && passwordText.value == "Ngoc@123" {
            LocalStorage.shared.appToken = "Token"
            actions?.showAuthorizedScreen(true)
        }
    }
    
    func onRegister() {
        actions?.showRegisterScreen()
    }
}
