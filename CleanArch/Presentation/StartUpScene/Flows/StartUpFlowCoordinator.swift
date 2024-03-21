import Foundation
import UIKit

protocol StartUpFlowCoordinatorDependencies {
    func makeSplashViewController(actions: SplashViewModelActions) -> SplashViewController
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makeIntroViewController(actions: IntroViewModelActions) -> IntroViewController
}

final class StartUpFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: StartUpFlowCoordinatorDependencies
    private weak var splashViewController: SplashViewController?

    
    init(navigationController: UINavigationController?, dependencies: StartUpFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = SplashViewModelActions(showIntroScreen: showIntroScreen, showLoginScreen: showLoginScreen, showHomeScreen: showHomeScreen)
        let vc = dependencies.makeSplashViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
        splashViewController = vc
    }
    
    func startFromLogin() {
        showLoginScreen()
    }
    
    private func showIntroScreen() {
        let actions = IntroViewModelActions(showLoginScreen: showLoginScreen)
        let vc = dependencies.makeIntroViewController(actions: actions)
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func showLoginScreen() {
        let actions = LoginViewModelActions(showHomeScreen: showHomeScreen)

        let vc = dependencies.makeLoginViewController(actions: actions)
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func showHomeScreen() {
        let dependencies = AuthorizedSceneDIContainer.Dependencies()
        
        let authorizedSceneDI =  AuthorizedSceneDIContainer(dependencies: dependencies)
        let flow = authorizedSceneDI.makeAuthorizedSceneFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
