import Foundation

struct HomeViewModelActions {
    let logout: () -> Void
}

protocol HomeViewModelInput {
    func logout()
}

protocol HomeViewModelOutput {
    
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {
    private var actions: HomeViewModelActions?
  
    init(actions: HomeViewModelActions? = nil) {
        self.actions = actions
    }
}

extension HomeViewModelImpl {
    // MARK: - Input
    func logout() {
        actions?.logout()
    }
}
