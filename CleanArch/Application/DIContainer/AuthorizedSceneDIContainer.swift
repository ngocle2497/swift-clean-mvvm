import Foundation
import UIKit

final class AuthorizedSceneDIContainer: AuthorizedSceneFlowCoordinatorDependencies {
    
    struct Dependencies {
        
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Home
    func makeHomeViewController(actions: HomeViewModelActions) -> HomeViewController {
        return HomeViewController.create(with: makeHomeViewModel(actions: actions))
    }
    
    func makeHomeViewModel(actions: HomeViewModelActions) -> HomeViewModel {
        return HomeViewModelImpl(actions: actions)
    }
    
    // MARK: - Flow
    func makeAuthorizedSceneFlowCoordinator(navigationController: UINavigationController?) -> AuthorizedSceneFlowCoordinator {
        return AuthorizedSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
