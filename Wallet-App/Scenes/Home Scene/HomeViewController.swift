//
//  HomeViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 26.02.2022.
//

import UIKit

protocol HomeSceneDisplayLogic: AnyObject {
    func displayContent(viewModel: HomeInfo.ShowInfo.ViewModel)
}

final class HomeViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    private enum Const {
        static let buttonSizeForLargeState = 35.0
        static let buttonSizeForSmallState = 15.0
        static let buttonRightMargin = 20.0
        static let buttonBottomMargin = 8.0
    }
    
    private enum SupplementaryViewKind {
        static let contact = "HeaderContact"
        static let history = "HeaderHistory"
    }
    
    enum Section: Hashable {
        case cards
        case contacts
        case history
    }
    
    private lazy var borderLayer: CAShapeLayer = {
        let border = CAShapeLayer()
        border.lineWidth = 3
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [3, 5]
        border.fillColor = nil
        border.needsDisplayOnBoundsChange = true

        return border
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.pinWidth(to: button.heightAnchor, 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: ContactCollectionViewCell.reuseIdentifier)
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier)
        
        collectionView.register(
            ContactHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: SupplementaryViewKind.contact,
            withReuseIdentifier: ContactHeaderCollectionReusableView.reuseIdentifier
        )
        collectionView.register(
            HistoryCollectionReusableView.self,
            forSupplementaryViewOfKind: SupplementaryViewKind.history,
            withReuseIdentifier: HistoryCollectionReusableView.reuseIdentifier
        )
        
        collectionView.dataSource = self.dataSource
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private var sections = [Section]()
    private var dataSource: DataSource?
    private var displayedCards = [HomeInfo.ShowInfo.ViewModel.DisplayedCard]()
    private var displayedContacts = [HomeInfo.ShowInfo.ViewModel.DisplayedContact]()
    private var displayedHistory = [HomeInfo.ShowInfo.ViewModel.DisplayedHistory]()
    private var interactor: (HomeBusinessLogic & HomeDataStore)?
    private var router: HomeRouterLogic?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupNavBar()
        setup()
        setupCollection()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.setNeedsDisplay()
        showButton(true)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showButton(false)
    }
    
    private func setup() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        self.interactor = interactor
        self.router = router
        router.controller = self
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    private func fetchData() {
        let request = HomeInfo.ShowInfo.Request()
        interactor?.showInformation(request: request)
    }
    
    //MARK: - configure UI
    private func setupCollection() {
        view.addSubview(collectionView)
        
        collectionView.pin(to: view, .left, .right)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Cards"
        navigationController?.navigationBar.prefersLargeTitles = true

        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 48, weight: .bold)]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(addButton)
        
        addButton.pin(to: navigationBar, [.right: Const.buttonRightMargin, .bottom: Const.buttonBottomMargin])
        addButton.setHeight(to: Const.buttonSizeForLargeState)
        
//        borderLayer.frame = addButton.bounds
        borderLayer.frame = CGRect(x: 0, y: 0, width: Const.buttonSizeForLargeState, height: Const.buttonSizeForLargeState)
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.frame, cornerRadius: addButton.layer.cornerRadius).cgPath
        addButton.layer.addSublayer(borderLayer)
    }
    
    private func moveAndResizeButton(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.buttonSizeForLargeState
            let heightDifferenceBetweenStates = (Const.buttonSizeForLargeState - Const.buttonSizeForSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.buttonSizeForSmallState / Const.buttonSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = Const.buttonSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            let maxYTranslation = Const.buttonBottomMargin - Const.buttonBottomMargin + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.buttonBottomMargin + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        addButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    private func showButton(_ show: Bool) {
        // remove addButton when new controller pushed
        UIView.animate(withDuration: 0.1) {
            self.addButton.alpha = show ? 1.0 : 0.0
        }
    }
    
    // MARK: - Layout
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let headerCItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let headerCItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerCItemSize, elementKind: SupplementaryViewKind.contact, alignment: .top)
            let headerHItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let headerHItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerHItemSize, elementKind: SupplementaryViewKind.history, alignment: .top)
            
            let section = self.sections[sectionIndex]
            switch section {
            case .cards:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.82),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20)
                
                // card size animation when scrolling
                section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, environment) in
                    let centerX = point.x + ScreenSize.Width / 2
                    visibleItems.forEach { item in
                        guard let cell = self?.collectionView.cellForItem(at: item.indexPath) as? CardCollectionViewCell
                        else { return }
                        if(cell.frame.minX <= centerX && cell.frame.maxX >= centerX) {
                            cell.transformToLarge()
                        } else {
                            cell.transformBack()
                        }
                    }
                }
        
                return section
            case .contacts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/7),
                    heightDimension: .fractionalWidth(1/7)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .none, trailing: .fixed(15), bottom: .none)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 5)
                section.boundarySupplementaryItems = [headerCItem]
                
                return section
            case .history:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(56)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .fixed(10), trailing: .none, bottom: .fixed(10))
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                section.boundarySupplementaryItems = [headerHItem]
                
                return section
            }
        }
        return layout
    }

}

// MARK: - DataSource
extension HomeViewController {
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section] {
            case .cards:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell
                cell?.configure(card: item as! HomeInfo.ShowInfo.ViewModel.DisplayedCard)
                
                return cell
            case .contacts:
                if(indexPath.row == 0) {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.reuseIdentifier, for: indexPath) as? ContactCollectionViewCell
                    cell?.configureAdd()
                    
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.reuseIdentifier, for: indexPath) as? ContactCollectionViewCell
                    cell?.configureNormal(contact: item as! HomeInfo.ShowInfo.ViewModel.DisplayedContact)
                    
                    return cell
                }
            case .history:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryCollectionViewCell
                cell?.configure(expense: item as! HomeInfo.ShowInfo.ViewModel.DisplayedHistory)
                
                return cell
            }
           
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case "HeaderContact":
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: SupplementaryViewKind.contact,
                    withReuseIdentifier: ContactHeaderCollectionReusableView.reuseIdentifier,
                    for: indexPath
                ) as! ContactHeaderCollectionReusableView
                
                return headerView
            case "HeaderHistory":
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: SupplementaryViewKind.history,
                    withReuseIdentifier: HistoryCollectionReusableView.reuseIdentifier,
                    for: indexPath
                ) as? HistoryCollectionReusableView
                
                headerView?.transitionClosure = { [weak self] in
                    self?.router?.routeToAnalytics()
                }
                
                return headerView
            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.cards, .contacts, .history])
        snapshot.appendItems(displayedCards, toSection: .cards)
        snapshot.appendItems(displayedContacts, toSection: .contacts)
        snapshot.appendItems(displayedHistory, toSection: .history)
        sections = snapshot.sectionIdentifiers
        dataSource?.apply(snapshot)
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeSceneDisplayLogic {
    func displayContent(viewModel: HomeInfo.ShowInfo.ViewModel) {
        self.displayedCards = viewModel.displayedCards
        self.displayedContacts = viewModel.displayedContact
        self.displayedHistory = viewModel.displayedHistory
        // addContact Button
        self.displayedContacts.insert(HomeInfo.ShowInfo.ViewModel.DisplayedContact(id: 0, imageURL: ""), at: 0)
        configureDataSource()
    }
}

// MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeButton(for: height)
    }
}

