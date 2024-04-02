import Foundation
import UIKit

class TabBar: UITabBar {
    
    private var buttons: [CBTabBarButton] = []
    override var selectedItem: UITabBarItem? {
        willSet {
            guard let newValue = newValue else {
                buttons.forEach { $0.setSelected(false, animated: false) }
                return
            }
            guard let index = items?.firstIndex(of: newValue),
                  index != NSNotFound else {
                return
            }
            
            select(itemAt: index, animated: false)
            
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            buttons.forEach { $0.tintColor = tintColor }
        }
    }
    
    override var items: [UITabBarItem]? {
        didSet {
            reloadViews()
        }
    }
    
    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    
    var barHeight: CGFloat = 60
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = barHeight
        if #available(iOS 11.0, *) {
            sizeThatFits.height = sizeThatFits.height + safeAreaInsets.bottom
        }
        return sizeThatFits
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let centerButtonWidth = 70.0
        let buttonCount = buttons.count % 2 == 0 ? buttons.count : (buttons.count + 1)
        let btnWidth = (bounds.width - centerButtonWidth) / CGFloat(buttonCount)
        let centerIndex = buttonCount / 2 - 1
        var btnHeight = bounds.height
        if #available(iOS 11.0, *) {
            btnHeight -= safeAreaInsets.bottom
        }
        
        for (index, button) in buttons.enumerated() {
            let buttonX =  btnWidth * CGFloat(index) + (index > centerIndex ? centerButtonWidth : 0)
            button.frame = CGRect(x: buttonX, y: 0, width: btnWidth, height: btnHeight)
            button.setNeedsLayout()
        }
    }
    
    func reloadViews() {
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }.forEach { $0.removeFromSuperview() }
        buttons.forEach { $0.removeFromSuperview()}
        buttons = items?.map { self.button(forItem: $0) } ?? []
        setNeedsLayout()
    }
    
    private func button(forItem item: UITabBarItem) -> CBTabBarButton {
        let button = CBTabBarButton(item: item)
        button.tintColor = tintColor
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        if selectedItem != nil && item === selectedItem {
            button.select(animated: false)
        }
        self.addSubview(button)
        return button
    }
    
    @objc private func btnPressed(sender: CBTabBarButton) {
        guard let index = buttons.firstIndex(of: sender),
              index != NSNotFound,
              let item = items?[index] else {
            return
        }
        buttons.forEach { (button) in
            guard button != sender else {
                return
            }
            button.setSelected(false, animated: true)
        }
        sender.setSelected(true, animated: true)
        delegate?.tabBar?(self, didSelect: item)
    }
    
    func select(itemAt index: Int, animated: Bool = false) {
        guard index < buttons.count else {
            return
        }
        let selectedbutton = buttons[index]
        buttons.forEach { (button) in
            guard button != selectedbutton else {
                return
            }
            button.setSelected(false, animated: false)
        }
        selectedbutton.setSelected(true, animated: false)
    }
}

class CBTabBarButton: UIControl {
    
    var tabImage = UIImageView()
    var tabLabel = UILabel()
    var dotView = UIView()
    
    private var _isSelected: Bool = false
    override var isSelected: Bool {
        get {
            return _isSelected
        }
        set {
            guard newValue != _isSelected else {
                return
            }
            if newValue {
                select(animated: false)
            } else {
                deselect(animated: false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    init(item: UITabBarItem) {
        super.init(frame: .zero)
        configureSubviews()
        defer {
            self.item = item
        }
    }
    
    var item: UITabBarItem? {
        didSet {
            tabImage.image = item?.image?.withRenderingMode(.alwaysTemplate)
            tabLabel.attributedText = attributedText(fortitle: item?.title)
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            tabImage.tintColor = tintColor.withAlphaComponent(0.4)
            tabLabel.textColor = tintColor
            dotView.backgroundColor = tintColor
        }
    }
    
    private func attributedText(fortitle title: String?) -> NSAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [:]
        attrs[.kern] = -0.2
        attrs[.foregroundColor] = tintColor
        attrs[.font] = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return NSAttributedString(string: title ?? "", attributes: attrs)
    }
    
    private func configureSubviews() {
        addSubview(tabLabel)
        addSubview(tabImage)
        addSubview(dotView)
        tabLabel.numberOfLines = 2
        tabLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        tabLabel.isHidden = true
        tabImage.contentMode = .center
        let dotSize: CGFloat = 5.0
        dotView.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize))
        dotView.layer.cornerRadius = dotSize / 2.0
        dotView.layer.shouldRasterize = true
        dotView.layer.rasterizationScale = UIScreen.main.scale
        dotView.isHidden = true
        self.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tabImage.sizeToFit()
        tabImage.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        tabLabel.frame = bounds
        tabLabel.sizeToFit()
        tabLabel.textAlignment = .center
        tabLabel.center = tabImage.center
        let dotX: CGFloat = tabImage.center.x - dotView.frame.width/2.0
        let dotY: CGFloat = tabLabel.frame.maxY + 13.0
        dotView.frame = CGRect(origin: CGPoint(x: dotX, y: dotY), size: dotView.frame.size)
        
        self.layer.borderWidth = 1
        
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            select(animated: animated)
        } else {
            deselect(animated: animated)
        }
    }
    
    func select(animated: Bool = true) {
        guard !_isSelected else {
            return
        }
        _isSelected = true
        tabLabel.isHidden = false
        tabImage.isHidden = true
        dotView.isHidden = false
    }
    
    func deselect(animated: Bool = true) {
        guard _isSelected else {
            return
        }
        _isSelected = false
        tabLabel.isHidden = true
        tabImage.isHidden = false
        dotView.isHidden = true
    }
    
}
