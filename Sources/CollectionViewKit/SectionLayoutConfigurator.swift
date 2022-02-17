import UIKit

public protocol SectionLayoutConfigurator {
    func layoutSize(environment: LayoutEnvironment) -> NSCollectionLayoutSize
    func item(environment: LayoutEnvironment) -> NSCollectionLayoutItem
    func group(environment: LayoutEnvironment) -> NSCollectionLayoutGroup
    func section(environment: LayoutEnvironment) -> NSCollectionLayoutSection
}

public extension SectionLayoutConfigurator {
    func layoutSize(environment: LayoutEnvironment) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(
            widthDimension: .absolute(environment.collectionLayoutEnvironment.container.effectiveContentSize.width),
            heightDimension: .absolute(44)
        )
    }

    func item(environment: LayoutEnvironment) -> NSCollectionLayoutItem {
        let layoutSize = layoutSize(environment: environment)
        return NSCollectionLayoutItem(layoutSize: layoutSize)
    }

    func group(environment: LayoutEnvironment) -> NSCollectionLayoutGroup {
        let item = item(environment: environment)
        let layoutSize = item.layoutSize

        return .vertical(layoutSize: layoutSize, subitems: [item])
    }
    
    func section(environment: LayoutEnvironment) -> NSCollectionLayoutSection {
        let group = group(environment: environment)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

