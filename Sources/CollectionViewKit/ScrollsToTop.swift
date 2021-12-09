import UIKit

public protocol ScrollsToTop {
    func isScrolledToTop() -> Bool
    func scrollToTop(animated: Bool)
}
