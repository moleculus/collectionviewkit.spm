import UIKit

public class CollectionViewConfiguration: NSObject, UICollectionViewDataSource {
    
    // MARK: - Injected Properties.
    
    private let collectionView: UICollectionView
    private let viewController: UIViewController
    
    // MARK: - Properties.
    
    open var sections: [SectionLayoutConfigurator & SectionDataSource] = [] {
        didSet {
            for section in sections {
                section.registerCell(collectionView: collectionView)
            }
        }
    }
    
    // MARK: - Computed Properties.
    
    open var compositionalLayoutConfiguration: UICollectionViewCompositionalLayoutConfiguration {
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
    
    public init(collectionView: UICollectionView, viewController: UIViewController) {
        self.collectionView = collectionView
        self.viewController = viewController
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
    
    // MARK: - Private Methods.
    
    open func section(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = sections[section]
        let environment = LayoutEnvironment(collectionLayoutEnvironment: environment, collectionView: collectionView, viewController: viewController)
        return section.section(environment: environment)
    }
    
}