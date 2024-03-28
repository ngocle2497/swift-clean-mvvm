import Foundation
import RxSwift
import RxCocoa

struct IntroViewModelActions {
    let showAuthenticationScreen: (Bool) -> Void
}

protocol IntroViewModelInput {
    func saveConfigIntroShown()
}

protocol IntroViewModelOutput {
    var publishSubject: PublishSubject<String> { get }
}

final class IntroViewModel: ViewModel, IntroViewModelInput, IntroViewModelOutput {
    
    let publishSubject = PublishSubject<String>()
    
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
