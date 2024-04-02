import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        window?.rootViewController = navigation
        
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigation, appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()

        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        InactiveView.show()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        InactiveView.hide()
    }
    
}

