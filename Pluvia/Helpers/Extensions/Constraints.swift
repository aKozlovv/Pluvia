import UIKit

extension UIView {
    
    // MARK: - Adding and TAMIC Off
    func addSubviewsUsingAutoLayout(_ views: UIView ...) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK: - Fixed anchors
    @discardableResult
    func toEdges(of view: UIView) -> Self {
        self
            .topAnchor(equalTo: view.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
        return self
    }
    
    @discardableResult
    func pin(to guide: UILayoutGuide) -> Self {
        self
            .topAnchor(equalTo: guide.topAnchor)
            .leadingAnchor(equalTo: guide.leadingAnchor)
            .trailingAnchor(equalTo: guide.trailingAnchor)
            .bottomAnchor(equalTo: guide.bottomAnchor)
        return self
    }
    
    @discardableResult
    func toUpperHalf(of view: UIView) -> Self {
        self
            .topAnchor(equalTo: view.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .heightAnchor(equalTo: view.heightAnchor, multiplier: 0.5)
        return self
    }
    
    @discardableResult
    func toBottomHalf(of view: UIView) -> Self {
        self
            .bottomAnchor(equalTo: view.bottomAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .heightAnchor(equalTo: view.heightAnchor, multiplier: 0.5)
        return self
    }
    
    @discardableResult
    func toCenter(of view: UIView) -> Self {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }
    
    
    // MARK: - Anchors methods
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(equalTo height: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(equalTo height: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func widthAncor(equalTo width: NSLayoutDimension, multiplier: CGFloat) -> Self {
        widthAnchor.constraint(equalTo: width, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(equalTo height: NSLayoutDimension, multiplier: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: height, multiplier: multiplier).isActive = true
        return self
    }
}
