import Foundation
import UIKit
import RxSwift
import RxCocoa


class TabBarViewController: UITabBarController {
    fileprivate var shouldSelectOnTabBar = true
    private var disposeBag = DisposeBag()
    
    override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }
    
    override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }
    
    
    func languageUpdate() {
        guard let items = tabBar.items else { return }
        
        items[0].title = S10n.Home.tabTitle
        items[1].title = S10n.Profile.tabTitle
        (self.tabBar as! TabBar).reloadViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTabBar = TabBar()
        self.setValue(customTabBar, forKey: "tabBar")
        
        GlobalSettings.shared.language.subscribe(with: self) { vc, _ in
            vc.languageUpdate()
        }.disposed(by: disposeBag)
        
        setupTab()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupTab() {
        let path = getPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor.lightGray.cgColor
        shape.strokeColor = UIColor.red.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.view.layoutIfNeeded()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        self.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
            
        }
    }
    
    
    func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + "Controller"
        return nav
    }
    
    private func getPath() -> UIBezierPath{
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 100
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frameWidth / 2 - 35, y: 0))
        path.addLine(to: CGPoint(x: frameWidth / 2, y: 50))
        path.addLine(to: CGPoint(x: frameWidth / 2 + 35, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        path.close()
        return path
    }
    var barHeight: CGFloat {
        get {
            return (tabBar as? TabBar)?.barHeight ?? tabBar.frame.height
        }
        set {
            (tabBar as? TabBar)?.barHeight = newValue
        }
    }
    private func updateTabBarFrame() {
        var tabFrame = tabBar.frame
        tabFrame.size.height = barHeight + view.safeAreaInsets.bottom
        tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateTabBarFrame()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
}
