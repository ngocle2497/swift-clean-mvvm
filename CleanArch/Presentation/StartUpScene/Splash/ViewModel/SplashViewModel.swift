import Foundation

struct SplashViewModelActions {
    let showIntroScreen: () -> Void
    let showAuthenticationScreen: (Bool) -> Void
    let showAuthorizedScreen: (Bool) -> Void
}

protocol SplashViewModelInput {
    func getConfig()
    func showNextScreen()
}

protocol SplashViewModelOutput {
    
}

typealias SplashViewModelType = SplashViewModelInput & SplashViewModelOutput

final class SplashViewModel:ViewModel, SplashViewModelType {
    
    private let actions: SplashViewModelActions?
    
    // MARK: - Output
    
    // MARK: - Init
    init(actions: SplashViewModelActions?) {
        self.actions = actions
    }
    
}

// MARK: - Input
extension SplashViewModel {
    func getConfig() {
        // TODO: get config, push event to View, View call showNextScreen
        
    }
    
    func showNextScreen() {
        if LocalStorage.shared.introShown {
            if LocalStorage.shared.appToken != nil {
                actions?.showAuthorizedScreen(false)
            } else {
                actions?.showAuthenticationScreen(false)
            }
        } else {
            actions?.showIntroScreen()
        }
    }
}
