import UIKit

class LoginViewController: UIViewController {

    private var vm: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let vc = LoginViewController()
        vc.vm = viewModel
        return vc
    }

    @IBAction func onLoginPresssed(_ sender: UIButton) {
        vm.onAuthorized()
    }
}
