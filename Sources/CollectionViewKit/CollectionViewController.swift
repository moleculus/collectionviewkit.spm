import UIKit

class CollectionViewController<UI: CollectionBasedView>: UIViewController {
    
    // MARK: - UI Properties.
    
    public let ui = UI(frame: .zero)
    
    // MARK: - Properties.
    
    lazy var configuration = CollectionViewConfiguration(
        collectionView: ui.collectionView,
        viewController: self
    )
    
    var biggestTopSafeAreaInset: CGFloat = 0
    
    // MARK: - Initialization.
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backButtonDisplayMode = .minimal
        
        ui.collectionView.collectionViewLayout = configuration.compositionalLayout
        ui.collectionView.dataSource = configuration
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
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.biggestTopSafeAreaInset = max(ui.safeAreaInsets.top, biggestTopSafeAreaInset)
    }
    
}

extension CollectionViewController: ScrollsToTop {
    func isScrolledToTop() -> Bool {
        return ui.collectionView.contentOffset.y == -biggestTopSafeAreaInset
    }
    
    func scrollToTop(animated: Bool) {
        ui.collectionView.setContentOffset(CGPoint(x: 0, y: -biggestTopSafeAreaInset), animated: animated)
    }
}
