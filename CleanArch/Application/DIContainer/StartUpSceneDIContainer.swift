import Foundation
import UIKit

final class StartUpSceneDIContainer: StartUpFlowCoordinatorDependencies {


    struct Dependencies {
        let apiService: String
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Splash
    func makeSplashViewController(actions: SplashViewModelActions) -> SplashViewController {
        return SplashViewController.create(with: makeSplashViewModel(actions: actions))
    }
    
    private func makeSplashViewModel(actions: SplashViewModelActions) -> SplashViewModel {
        return SplashViewModel(actions: actions)
    }
    
    // MARK: - Intro
    func makeIntroViewController(actions: IntroViewModelActions) -> IntroViewController {
        return IntroViewController.create(with: makeIntroViewModel(actions: actions))
    }
    
    func makeIntroViewModel(actions: IntroViewModelActions) -> IntroViewModel {
        return IntroViewModel(actions: actions)
    }
    
    
    // MARK: - Flow
    func makeStartUpFlowCoordinator(navigationController: UINavigationController?) -> StartUpFlowCoordinator {
        return StartUpFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
