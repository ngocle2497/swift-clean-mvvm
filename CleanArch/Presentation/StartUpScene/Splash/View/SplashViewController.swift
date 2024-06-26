import UIKit

class SplashViewController: ViewController<SplashViewModel> {

    
    @IBOutlet weak var iconSplashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getConfig()
        hideSplash()
    }

    static func create(with viewModal: SplashViewModel) -> SplashViewController{
        let view =  SplashViewController(vm: viewModal)
        return view
    }
    
    private func hideSplash() {
        UIView.animate(withDuration: 1) {
            self.iconSplashImageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.iconSplashImageView.alpha = 0
        } completion: { finished in
            if finished {
                self.vm.showNextScreen()
            }
        }

    }
}
