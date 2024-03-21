import UIKit

class HomeViewController: UIViewController {

    private var vm: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let vc = HomeViewController()
        vc.vm = viewModel
        return vc
    }

    @IBAction func onLogoutPressed(_ sender: UIButton) {
        vm.logout()
    }
}
