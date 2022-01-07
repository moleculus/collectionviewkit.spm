import UIKit

public protocol SectionDataSource {
    associatedtype ReusableView: UIView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func registerCell(collectionView: UICollectionView)
}
