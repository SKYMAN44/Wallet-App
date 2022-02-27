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
    
    enum Section: Hashable {
        case cards
        case contacts
        case history
    }

    private var sections = [Section]()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self.dataSource
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var dataSource: DataSource?
    private var displayedCards = [HomeInfo.ShowInfo.ViewModel.DisplayedCard]()
    var interactor: (HomeBusinessLogic & HomeDataStore)?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [.cards, .contacts]
        setup()
        setupCollection()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setup() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        self.interactor = interactor
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
        
        collectionView.pin(to: view, .left, .right, .top)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    
    // MARK: - Layout
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section {
            case .cards:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(150)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
                
                section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, environment) in
                    let centerPoint = CGPoint(x: point.x + self!.view.frame.width / 2, y: 100)
                    
                    visibleItems.forEach { item in
                        guard let cell = self?.collectionView.cellForItem(at: item.indexPath) as? CardCollectionViewCell else { return }
                        
                        if(item.frame.contains(centerPoint)) {
                            cell.transformToLarge()
                        } else {
                            cell.transformBack()
                        }
                    }
                }
                
                return section
            case .contacts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(300)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            case .history:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(300)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
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
            default:
                fatalError("Pizdets")
            }
           
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.cards])
        
        snapshot.appendItems(displayedCards, toSection: .cards)
        sections = snapshot.sectionIdentifiers
        dataSource?.apply(snapshot)
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeSceneDisplayLogic {
    func displayContent(viewModel: HomeInfo.ShowInfo.ViewModel) {
        self.displayedCards = viewModel.displayedCards
        configureDataSource()
    }
}

