import UIKit

public protocol SectionDataSource {
    associatedtype ReusableView: UIView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func render(_ ui: ReusableView, at indexPath: IndexPath)
    func registerCell(collectionView: UICollectionView)
}
