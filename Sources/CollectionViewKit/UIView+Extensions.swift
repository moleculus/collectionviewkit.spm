import UIKit

extension UIView {
    @objc open func prepareForReuse() {}
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
