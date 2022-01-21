import UIKit

public class CollectionViewConfiguration: NSObject, UICollectionViewDataSource {
    
    // MARK: - Injected Properties.
    
    private weak var collectionView: UICollectionView!
    
    // MARK: - Properties.
    
    public var sections: [LayoutSection] = [] {
        didSet {
            for section in sections {
                section.registerCell(collectionView: collectionView)
            }
        }
    }
    
    public var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    
    // MARK: - Computed Properties.
    
    public var compositionalLayoutConfiguration: UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        configuration.scrollDirection = .vertical
        configuration.contentInsetsReference = .safeArea
        configuration.interSectionSpacing = 0
        configuration.boundarySupplementaryItems = []
        
        return configuration
    }
    
    public var compositionalLayout: UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(
            sectionProvider: section(section:environment:),
            configuration: compositionalLayoutConfiguration
        )
    }
            
    // MARK: - Initialization.
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: - UICollectionViewDataSource.
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    // MARK: - UICollectionViewCompositionalLayout.
    
    private func section(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = sections[section]
        let environment = LayoutEnvironment(collectionLayoutEnvironment: environment, collectionView: collectionView)
        
        let layoutSection = section.section(environment: environment)
        layoutSection.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler
        return layoutSection
    }
    
}
