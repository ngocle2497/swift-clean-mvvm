import UIKit
import RxSwift

class LoginViewController: ViewController<LoginViewModel> {
    
    @IBOutlet weak var passwordView: InputView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailView: InputView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let vc = LoginViewController(vm: viewModel)
        return vc
    }
    
    override func setupText() {
        emailView.titleLabel.text = S10n.Login.email
        emailView.inputTextField.placeholder = S10n.Login.email
        
        passwordView.titleLabel.text = S10n.Login.password
        passwordView.inputTextField.placeholder = S10n.Login.password
    }
    
    override func languageUpdate() {
        super.languageUpdate()
        vm.emailText.accept(vm.emailText.value)
        vm.passwordText.accept(vm.passwordText.value)
    }
    
    override func setupView() {
        emailView.inputTextField.font = .title1Regular
        emailView.titleLabel.font = .title1Regular
        emailView.titleLabel.textColor = .secondaryFocus
        
        passwordView.inputTextField.font = .title1Regular
        passwordView.titleLabel.font = .title1Regular
        passwordView.titleLabel.textColor = .secondaryFocus
        passwordView.inputTextField.isSecureTextEntry = true
    }
    
    override func setupRx() {
        passwordView.inputTextField.rx.text.bind(to: vm.passwordText).disposed(by: disposeBag)
        emailView.inputTextField.rx.text.bind(to: vm.emailText).disposed(by: disposeBag)
        
        submitButton.rx.tap
            .subscribe(with: self, onNext: {vc,_ in
                vc.vm.onAuthorized()
            }).disposed(by: disposeBag)
        
        registerButton.rx.tap.subscribe(with: self, onNext: { vc,_ in
//            vc.vm.onRegister()
            GlobalSettings.shared.updateLanguage { oldValue in
               return oldValue == .vietnam ? .english : .vietnam
            }
//            vc.appSettings.language = vc.appSettings.language == .english ? .vietnam : .english
        }).disposed(by: disposeBag)
        
        vm.errorEmail.subscribe(with: self, onNext: {vc, errorMessgae in
            vc.emailView.setError(error: errorMessgae)
        }).disposed(by: disposeBag)
        
        vm.errorPassword.subscribe(with: self, onNext: {vc, errorMessgae in
            vc.passwordView.setError(error: errorMessgae)
        }).disposed(by: disposeBag)
    }

}
