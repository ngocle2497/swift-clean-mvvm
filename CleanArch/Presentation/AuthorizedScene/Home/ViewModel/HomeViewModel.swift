import Foundation

struct HomeViewModelActions {
    let logout: () -> Void
}

protocol HomeViewModelInput {
    func logout()
}

protocol HomeViewModelOutput {
    
}

typealias HomeViewModelType = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: ViewModel, HomeViewModelType {
    private var actions: HomeViewModelActions?
  
    init(actions: HomeViewModelActions? = nil) {
        self.actions = actions
    }
}

extension HomeViewModel {
    // MARK: - Input
    func logout() {
        LocalStorage.shared.appToken = nil
        actions?.logout()
    }
}
