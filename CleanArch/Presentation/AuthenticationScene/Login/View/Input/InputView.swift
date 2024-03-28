import UIKit
import RxSwift
import RxCocoa

class InputView: BView {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var isDirty = BehaviorRelay<Bool>(value: false)
    private var errorMessage = BehaviorRelay<String?>(value: nil)
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setup() {
        Observable.combineLatest(isDirty, errorMessage).map { (isDirty, message) in
            return isDirty && message != nil
        }
        .skip(2)
        .subscribe { needToShowError in
            if needToShowError {
                self.showError(error: self.errorMessage.value ?? "")
            } else {
                self.hideError()
            }
        }.disposed(by: disposeBag)
        
        Observable.merge([inputTextField.rx.controlEvent(.editingChanged).asObservable(),
                          inputTextField.rx.controlEvent(.editingDidEnd).asObservable()]).subscribe { event in
            self.isDirty.accept(true)
        }.disposed(by: disposeBag)
        
    }
    
    func setError(error: String?) {
        errorMessage.accept(error)
    }
    
    private func showError(error: String) {
        self.errorLabel.text = error
        UIView.animate(withDuration: 0.1) {
            self.errorLabel.isHidden = false
            self.layoutIfNeeded()
        }
    }
    
    private func hideError() {
        self.errorLabel.text = nil
        UIView.animate(withDuration: 0.1) {
            self.errorLabel.isHidden = true
            self.layoutIfNeeded()
        }
    }
    
}
