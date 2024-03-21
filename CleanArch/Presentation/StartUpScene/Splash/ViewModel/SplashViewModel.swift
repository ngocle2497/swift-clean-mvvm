import Foundation

struct SplashViewModelActions {
    let showIntroScreen: () -> Void
    let showLoginScreen: () -> Void
    let showHomeScreen: () -> Void
}

protocol SplashViewModelInput {
    func getConfig()
    func showNextScreen()
}

protocol SplashViewModelOutput {
    
}

typealias SplashViewModel = SplashViewModelInput & SplashViewModelOutput

final class SplashViewModelImpl: SplashViewModel {
    
    private let actions: SplashViewModelActions?
    
    // MARK: - Output
    
    // MARK: - Init
    init(actions: SplashViewModelActions?) {
        self.actions = actions
    }
    
}

// MARK: - Input
extension SplashViewModelImpl {
    func getConfig() {
        // TODO: get config, push event to View, View call showNextScreen
        
    }
    
    func showNextScreen() {
        actions?.showIntroScreen()
    }
}
