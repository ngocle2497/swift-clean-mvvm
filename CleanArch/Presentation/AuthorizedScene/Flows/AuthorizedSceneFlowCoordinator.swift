import Foundation
import UIKit

protocol AuthorizedSceneFlowCoordinatorDependencies {
    func makeHomeViewController() -> HomeViewController
    func makeProfileViewController(actions: ProfileViewModelActions) -> ProfileViewController

}

final class AuthorizedSceneFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: AuthorizedSceneFlowCoordinatorDependencies
    private weak var tabBarViewController: TabBarViewController?
    
    init(navigationController: UINavigationController? = nil, dependencies: AuthorizedSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(animated: Bool) {
        let profileActions = ProfileViewModelActions(logout: logout)
        let homeViewController = dependencies.makeHomeViewController()
        
        let profileController = dependencies.makeProfileViewController(actions: profileActions)
        let vc = TabBarViewController()
        let home = vc.createNav(with: S10n.Home.tabTitle, and: UIImage(systemName: "house"), vc: homeViewController)
        let profile = vc.createNav(with: S10n.Profile.tabTitle, and: UIImage(systemName: "person"), vc: profileController)
        vc.setViewControllers([home, profile], animated: true)
        navigationController?.setViewControllers([vc], animated: animated)
        
        tabBarViewController = vc
    }
    
    private func logout() {
        let container = AuthenticationDIContainer()
        let flow = container.makeAuthenticationSceneFlowCoordinator(navigationController: navigationController)
        flow.start(animated: true)
    }}
