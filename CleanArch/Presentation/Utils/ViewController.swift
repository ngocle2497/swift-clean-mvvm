import Foundation
import UIKit
import RxSwift

class ViewController<VM: ViewModel>: UIViewController {
    private let viewModel: VM!
    var vm: VM {
        get {
            return viewModel
        }
    }
    let disposeBag = DisposeBag()

    required init(vm: VM, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        viewModel = vm
        let resourceName = nibNameOrNil ?? String(describing: Self.self)
        if Bundle.main.path(forResource: resourceName, ofType: "xib") == nil {
            super.init(nibName: nil, bundle: nil)
        } else {
            super.init(nibName: resourceName, bundle: nibBundleOrNil)
        }
    }

    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        setupText()
        setupRx()
    }
    
    func setup() {
        
    }
    
    func setupView() {
        
    }
    
    func setupText() {
        
    }
    
    func setupRx() {
        
    }
    
}

class ViewModel {
    private(set) var disposeBag = DisposeBag()
    
    deinit {
        debugPrint("\(String(describing: self)) deinit")
    }
}
