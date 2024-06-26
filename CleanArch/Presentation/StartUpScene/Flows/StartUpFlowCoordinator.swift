import Foundation
import UIKit

protocol StartUpFlowCoordinatorDependencies {
    func makeSplashViewController(actions: SplashViewModelActions) -> SplashViewController
    
    func makeIntroViewController(actions: IntroViewModelActions) -> IntroViewController
}

final class StartUpFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: StartUpFlowCoordinatorDependencies
    
    
    init(navigationController: UINavigationController?, dependencies: StartUpFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = SplashViewModelActions(showIntroScreen: showIntroScreen, showAuthenticationScreen: showAuthenticationScreen, showAuthorizedScreen: showAuthorizedScreen)
        let vc = dependencies.makeSplashViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func startFromLogin() {
        showAuthenticationScreen(true)
    }
    
    private func showIntroScreen() {
        let actions = IntroViewModelActions(showAuthenticationScreen: showAuthenticationScreen)
        let vc = dependencies.makeIntroViewController(actions: actions)
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func showAuthenticationScreen(_ animated: Bool) {
        let authenticationSceneDI =  AuthenticationDIContainer()
        let flow = authenticationSceneDI.makeAuthenticationSceneFlowCoordinator(navigationController: navigationController)
        flow.start(animated: animated)
    }
    
    private func showAuthorizedScreen(_ animated: Bool) {
        let dependencies = AuthorizedSceneDIContainer.Dependencies()
        
        let authorizedSceneDI =  AuthorizedSceneDIContainer(dependencies: dependencies)
        let flow = authorizedSceneDI.makeAuthorizedSceneFlowCoordinator(navigationController: navigationController)
        flow.start(animated: animated)
    }
}
