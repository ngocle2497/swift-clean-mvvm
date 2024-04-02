import Foundation
import RxSwift
import RxCocoa
import AVFoundation

struct IntroViewModelActions {
    let showAuthenticationScreen: (Bool) -> Void
}

protocol IntroViewModelInput {
    func saveConfigIntroShown()
}

protocol IntroViewModelOutput {
    
}

final class IntroViewModel: ViewModel, IntroViewModelInput, IntroViewModelOutput {
    
    private let actions: IntroViewModelActions?
    
    init(actions: IntroViewModelActions?) {
        self.actions = actions
    }
    
}

extension IntroViewModel {
    // MARK: - Input
    func saveConfigIntroShown() {
        // TODO: Save config intro screen shown.
        LocalStorage.shared.introShown = true
        actions?.showAuthenticationScreen(true)
    }
}
