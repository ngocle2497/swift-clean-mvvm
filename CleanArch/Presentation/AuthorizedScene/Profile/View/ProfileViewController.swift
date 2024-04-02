import UIKit

class ProfileViewController: ViewController<ProfileViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        return ProfileViewController(vm: viewModel)
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        GlobalSettings.shared.updateLanguage { oldValue in
            return oldValue == .vietnam ? .english : .vietnam
        }
        vm.logout()
    }
}
