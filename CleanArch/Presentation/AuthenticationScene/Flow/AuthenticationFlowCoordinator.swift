import Foundation
import UIKit

protocol AuthenticationFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makeRegisterViewController(actions: RegisterViewModelActions) -> RegisterViewController
}

final class AuthenticationFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: AuthenticationFlowCoordinatorDependencies
//    private weak var loginController: LoginViewController?
    
    init(navigationController: UINavigationController? = nil, dependencies: AuthenticationFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(animated: Bool) {
        let actions = LoginViewModelActions(showAuthorizedScreen: showAuthorizedScreen, showRegisterScreen: showRegisterScreen)
        let vc = dependencies.makeLoginViewController(actions: actions)

        navigationController?.setViewControllers([vc], animated: animated)
//        loginController = vc
        
    }
    
    private func showRegisterScreen() {
        let actions = RegisterViewModelActions(showLoginScreen: backToLoginScreen)
        let vc = dependencies.makeRegisterViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func backToLoginScreen() {
//        if let vc = loginController {
            navigationController?.popViewController(animated: true)
//        }
    }
    
    private func showAuthorizedScreen(_ animated: Bool) {
        let dependencies = AuthorizedSceneDIContainer.Dependencies()
        
        let authorizedSceneDI =  AuthorizedSceneDIContainer(dependencies: dependencies)
        let flow = authorizedSceneDI.makeAuthorizedSceneFlowCoordinator(navigationController: navigationController)
        flow.start(animated: animated)
    }
}
