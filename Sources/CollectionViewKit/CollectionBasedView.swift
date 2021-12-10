import UIKit

public protocol CollectionBasedView: UIView {
    var collectionView: UICollectionView { get }
    var refreshControl: UIRefreshControl { get }
}
