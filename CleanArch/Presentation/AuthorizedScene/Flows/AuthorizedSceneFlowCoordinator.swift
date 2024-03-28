import Foundation
import UIKit

protocol AuthorizedSceneFlowCoordinatorDependencies {
    func makeHomeViewController(actions: HomeViewModelActions) -> HomeViewController
}

final class AuthorizedSceneFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: AuthorizedSceneFlowCoordinatorDependencies
    private weak var homeViewController: HomeViewController?
    
    init(navigationController: UINavigationController? = nil, dependencies: AuthorizedSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(animated: Bool) {
        let actions = HomeViewModelActions(logout: logout)
        let vc = dependencies.makeHomeViewController(actions: actions)
        navigationController?.setViewControllers([vc], animated: animated)
        homeViewController = vc
    }
    
    private func logout() {
        let container = AuthenticationDIContainer()
        let flow = container.makeAuthenticationSceneFlowCoordinator(navigationController: navigationController)
        flow.start(animated: true)
    }}
