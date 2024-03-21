import Foundation

struct IntroViewModelActions {
    let showLoginScreen: () -> Void
}

protocol IntroViewModelInput {
    func saveConfigIntroShown()
}

typealias IntroViewModel = IntroViewModelInput

final class IntroViewModelImpl: IntroViewModel {
    
    private let actions: IntroViewModelActions?

    init(actions: IntroViewModelActions?) {
        self.actions = actions
    }
}

extension IntroViewModelImpl {
    // MARK: - Input
    func saveConfigIntroShown() {
        // TODO: Save config intro screen shown.
        actions?.showLoginScreen()
    }
}
