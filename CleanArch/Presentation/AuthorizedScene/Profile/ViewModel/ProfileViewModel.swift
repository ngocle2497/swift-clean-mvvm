import Foundation

struct ProfileViewModelActions {
    let logout: () -> Void
}

protocol ProfileViewModelInput {
    func logout()
    func changeLanguage()
}

protocol ProfileViewModelOutput {
    
}

typealias ProfileViewModelType = HomeViewModelInput & HomeViewModelOutput

final class ProfileViewModel: ViewModel, ProfileViewModelType {
    private var actions: ProfileViewModelActions?
  
    init(actions: ProfileViewModelActions? = nil) {
        self.actions = actions
    }
}

extension ProfileViewModel {
    // MARK: - Input
    func logout() {
        LocalStorage.shared.appToken = nil
        actions?.logout()
    }
    func changeLanguage() {
        
    }
}
