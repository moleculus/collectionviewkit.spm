import UIKit

open class CollectionViewController<UI: CollectionBasedView>: UIViewController, ScrollsToTop {
    
    // MARK: - UI Properties.
    
    public let ui = UI(frame: .zero)
    
    // MARK: - Properties.
    
    public lazy var configuration = CollectionViewConfiguration(collectionView: ui.collectionView)
    public var biggestTopSafeAreaInset: CGFloat = 0
    
    // MARK: - Initialization.
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backButtonDisplayMode = .minimal
        
        ui.collectionView.collectionViewLayout = configuration.compositionalLayout
        ui.collectionView.dataSource = configuration
        ui.collectionView.delegate = configuration
    }
    
    @available(*, unavailable, message: "Loading this controller from a nib is unsupported")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this controller from a nib is unsupported")
    }
    
    // MARK: - Lifecycle.
    
    public override func loadView() {
        super.loadView()
        view = ui
        ui.frame = parent?.view.frame ?? presentingViewController?.view.frame ?? CGRect(x: 0, y: 0, width: 375, height: 812)
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        if !ui.refreshControl.isRefreshing {
            self.biggestTopSafeAreaInset = max(ui.safeAreaInsets.top, biggestTopSafeAreaInset)
        }
    }
    
    // MARK: - ScrollsToTop.
    
    @objc dynamic
    open func isScrolledToTop() -> Bool {
        return ui.collectionView.contentOffset.y == -biggestTopSafeAreaInset
    }
    
    @objc dynamic
    open func scrollToTop(animated: Bool) {
        ui.collectionView.setContentOffset(CGPoint(x: 0, y: -biggestTopSafeAreaInset), animated: animated)
    }
}
