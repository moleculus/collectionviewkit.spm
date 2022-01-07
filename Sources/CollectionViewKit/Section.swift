import UIKit

open class Section: SectionLayoutConfigurator, SectionDataSource, Identifiable {
    
    public typealias ReusableView = UIView
    
    // MARK: - Properties.
    
    open var id: String = UUID().uuidString
    
    // MARK: - Initialization.
    
    public init() {}
    
    // MARK: - DataSource.
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(reusableView: ReusableView.self, for: indexPath) { [weak self] in
            self?.render($0, at: indexPath)
        }
    }
    
    open func render(_ ui: ReusableView, at indexPath: IndexPath) {
        
    }
    
    public func registerCell(collectionView: UICollectionView) {
        collectionView.register(reusableView: ReusableView.self)
    }
    
    // MARK: - Layout.
    
    open func layoutSize(environment: LayoutEnvironment) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(
            widthDimension: .absolute(environment.collectionLayoutEnvironment.container.effectiveContentSize.width),
            heightDimension: .absolute(44)
        )
    }
    
    open func item(environment: LayoutEnvironment) -> NSCollectionLayoutItem {
        let layoutSize = layoutSize(environment: environment)
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        item.contentInsets = .zero
        item.edgeSpacing = nil
        
        return item
    }
        
    open func group(environment: LayoutEnvironment) -> NSCollectionLayoutGroup {
        let item = item(environment: environment)
        let layoutSize = item.layoutSize
        
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: layoutSize, subitems: [item])

        group.supplementaryItems = []
        group.interItemSpacing = .fixed(0)
        group.contentInsets = .zero
        group.edgeSpacing = nil
                
        return group
    }
    
    open func section(environment: LayoutEnvironment) -> NSCollectionLayoutSection {
        let group = group(environment: environment)
        let section = NSCollectionLayoutSection(group: group)
        
        section.decorationItems = []
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 0
        section.contentInsetsReference = .none
        section.contentInsets = .zero
        section.boundarySupplementaryItems = []
        section.supplementariesFollowContentInsets = true
        section.visibleItemsInvalidationHandler = nil
        
        return section
    }
    
    // MARK: - Identifier.
    
    public func identified(by identifier: String) -> Self {
        self.id = identifier
        return self
    }
        
}
