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
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController.create(with: makeHomeViewModel())
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    // MARK: - Profile
    func makeProfileViewController(actions: ProfileViewModelActions) -> ProfileViewController {
        return ProfileViewController.create(with: makeProfileViewModel(actions: actions))
    }
    
    func makeProfileViewModel(actions: ProfileViewModelActions) -> ProfileViewModel {
        return ProfileViewModel(actions: actions)
    }
        
    // MARK: - Flow
    func makeAuthorizedSceneFlowCoordinator(navigationController: UINavigationController?) -> AuthorizedSceneFlowCoordinator {
        return AuthorizedSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
