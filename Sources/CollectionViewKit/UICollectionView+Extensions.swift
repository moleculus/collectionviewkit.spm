import UIKit

extension UICollectionView {
    public convenience init(direction: UICollectionView.ScrollDirection) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = direction
             
        self.init(frame: .zero, collectionViewLayout: flowLayout)
    }
    
    public func dequeue<T: UIView>(reusableView: T.Type, for indexPath: IndexPath, then completion: ((T) -> Void)?) -> Cell<T> {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! Cell<T>
        completion?(cell.customView)
        return cell
    }
        
    public func register<T>(reusableView: T.Type) where T: UIView {
        register(Cell<T>.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
