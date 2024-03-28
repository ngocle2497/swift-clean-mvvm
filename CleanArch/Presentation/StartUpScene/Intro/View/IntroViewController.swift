import UIKit
import ObjectMapper
import Foundation
import RxSwift

class IntroViewController: ViewController<IntroViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create(with viewModal: IntroViewModel) -> IntroViewController {
        let vc = IntroViewController(vm: viewModal)
        return vc
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        vm.saveConfigIntroShown()
    }
    
    override func setup() {
        super.setup()
        print("Setup O")
    }
    
    override func setupView() {
        
    }
    
    override func setupText() {
        
    }
    
    override func setupRx() {
        vm.publishSubject.subscribe(onNext: {string in
            print("Sub: \(string)")
        }).disposed(by: disposeBag)
    }
}
