import UIKit

public class CollectionViewConfiguration: NSObject, UICollectionViewDataSource {
    
    // MARK: - Injected Properties.
    
    private weak var collectionView: UICollectionView!
    private weak var viewController: UIViewController!
    
    // MARK: - Properties.
    
    public var sections: [SectionLayoutConfigurator & SectionDataSource & Reloadable] = [] {
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
    
    public init(collectionView: UICollectionView, viewController: UIViewController) {
        self.collectionView = collectionView
        self.viewController = viewController
    }
    
    // MARK: - Public Methods.
    
    public func reloadSections(_ sections: [SectionLayoutConfigurator & SectionDataSource & Reloadable]) {
        var sectionsToReload: [Int] = []
        
        for i in 0..<sections.count {
            if sections[i].hashValue != self.sections[i].hashValue {
                sectionsToReload.append(i)
            }
        }
        
        self.sections = sections
        self.collectionView.reloadSections(IndexSet(sectionsToReload))
        
        print(sectionsToReload)
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
        let environment = LayoutEnvironment(collectionLayoutEnvironment: environment, collectionView: collectionView, viewController: viewController)
        
        let layoutSection = section.section(environment: environment)
        layoutSection.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler
        return layoutSection
    }
    
}
