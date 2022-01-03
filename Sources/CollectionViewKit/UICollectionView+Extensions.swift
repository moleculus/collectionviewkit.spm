import UIKit

extension UICollectionView {
    public convenience init(direction: UICollectionView.ScrollDirection) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = direction
             
        self.init(frame: .zero, collectionViewLayout: flowLayout)
    }
}
