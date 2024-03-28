import Foundation
import UIKit

final class AuthenticationDIContainer: AuthenticationFlowCoordinatorDependencies {
    
    // MARK: - Login
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return LoginViewModel(actions: actions, userUseCase: makeUserUseCase())
    }
    
    func makeUserUseCase() -> UserUseCase {
        return UserUseCaseImpl(userRepository: makeUserRepository())
    }
    
    func makeUserRepository() -> UserRepository {
        return UserRepositoriesImpl()
    }

    // MARK: - Register
    func makeRegisterViewController(actions: RegisterViewModelActions) -> RegisterViewController {
        return RegisterViewController.create(with: makeRegisterViewModel(actions: actions))
    }
    
    func makeRegisterViewModel(actions: RegisterViewModelActions) -> RegisterViewModel {
        return RegisterViewModel(actions: actions)
    }
    
    // MARK: - Flow
    func makeAuthenticationSceneFlowCoordinator(navigationController: UINavigationController?) -> AuthenticationFlowCoordinator {
        return AuthenticationFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
