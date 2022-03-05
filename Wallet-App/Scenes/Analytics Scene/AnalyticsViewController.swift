//
//  AnalyticsViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 01.03.2022.
//

import UIKit

protocol AnalyticsDisplayLogic: AnyObject {
    func displayContent(viewModel: AnalyticsInfo.ShowInfo.ViewModel)
}

final class AnalyticsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    enum Section: Hashable {
        case history
    }
    
    enum SupplementaryViewKind {
        static let graph = "graph"
    }

    private var sections = [Section]()
    
    private let segmentController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Week", "Month", "Year"])
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(StatGraphicsCollectionReusableView.self, forSupplementaryViewOfKind: SupplementaryViewKind.graph, withReuseIdentifier: StatGraphicsCollectionReusableView.reuseIdentifier)
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private var dataSource: DataSource?
    private var displayedHistory = [AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory]()
    var interactor: (AnalyticsBusinessLogic & AnalyticsDataStore)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = ""
       
        self.title = "Analytics"
        self.view.backgroundColor = .white
        
        setup()
        setupView()
        fetchData()
    }
    
    private func setup() {
        let interactor = AnalyticsInteractor()
        let presenter = AnalyticsPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    private func fetchData() {
        let request = AnalyticsInfo.ShowInfo.Request()
        interactor?.showInformation(request: request)
    }
    
    // MARK: - configure UI
    private func setupView() {
        view.addSubview(segmentController)
        
        segmentController.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        segmentController.pin(to: view, [.left: 20, .right: 20])
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.pin(to: view, [.left, .right])
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: segmentController.bottomAnchor)
    }
    
    // MARK: - Layout
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let graphItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
            let graphItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: graphItemSize, elementKind: SupplementaryViewKind.graph, alignment: .top)
            graphItem.pinToVisibleBounds = true
            
            let section = self.sections[sectionIndex]
            switch section {
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
                section.boundarySupplementaryItems = [graphItem]
                
                return section
            default:
                return nil
            }
        }
        return layout
    }
    
    //MARK: - DataSource
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section] {
            case .history:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryCollectionViewCell
                let itemY = item as! AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory
                let newItem = HomeInfo.ShowInfo.ViewModel.DisplayedHistory(recieverName: itemY.recieverName, date: itemY.date, image: itemY.image, amount: itemY.amount)
                cell?.configure(expense: newItem)
                
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplementaryViewKind.graph:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.graph, withReuseIdentifier: StatGraphicsCollectionReusableView.reuseIdentifier, for: indexPath) as! StatGraphicsCollectionReusableView
                
                return headerView
            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.history])
        snapshot.appendItems(displayedHistory, toSection: .history)
        sections = snapshot.sectionIdentifiers
        dataSource?.apply(snapshot)
    }
    
}

// MARK: - DisplayLogic
extension AnalyticsViewController: AnalyticsDisplayLogic {
    func displayContent(viewModel: AnalyticsInfo.ShowInfo.ViewModel) {
        self.displayedHistory = viewModel.displayedHistory
        configureDataSource()
    }
}
