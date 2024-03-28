import UIKit

class RegisterViewController: ViewController<RegisterViewModel> {

    @IBOutlet weak var backLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func create(with viewModel: RegisterViewModel) -> RegisterViewController{
        let vc = RegisterViewController(vm: viewModel)
        return vc
    }

    override func setupRx() {
        backLoginButton.rx.tap.subscribe(with: self ,onNext: { vc, _ in
            vc.vm.goBack()
        }).disposed(by: disposeBag)
    }
    
}
