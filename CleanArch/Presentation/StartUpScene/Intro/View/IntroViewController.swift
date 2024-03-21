import UIKit

class IntroViewController: UIViewController {

    private var vm: IntroViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    static func create(with viewModal: IntroViewModel) -> IntroViewController {
        let vc = IntroViewController()
        vc.vm = viewModal
        return vc
    }

    @IBAction func onButtonPressed(_ sender: UIButton) {
        vm.saveConfigIntroShown()
    }
}
