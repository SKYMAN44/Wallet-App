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
        collectionView.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: ContactCollectionViewCell.reuseIdentifier)
        
        collectionView.register(CardHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: CardHeaderCollectionReusableView.reuseIdentifier)
        collectionView.register(ContactHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "HeaderContact", withReuseIdentifier: ContactHeaderCollectionReusableView.reuseIdentifier)
        collectionView.dataSource = self.dataSource
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var dataSource: DataSource?
    private var displayedCards = [HomeInfo.ShowInfo.ViewModel.DisplayedCard]()
    private var displayedContacts = [HomeInfo.ShowInfo.ViewModel.DisplayedContact]()
    var interactor: (HomeBusinessLogic & HomeDataStore)?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .white
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
        
        collectionView.pin(to: view, .left, .right)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    
    // MARK: - Layout
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "Header", alignment: .top)
            let headerCItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let headerCItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerCItemSize, elementKind: "HeaderContact", alignment: .top)
            
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20)
                
                section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, environment) in
                    let centerPoint = CGPoint(x: point.x + self!.view.frame.width / 2, y: 200)
                    
                    visibleItems.forEach { item in
                        guard let cell = self?.collectionView.cellForItem(at: item.indexPath) as? CardCollectionViewCell else { return }
                        
                        if(item.frame.contains(centerPoint)) {
                            cell.transformToLarge()
                        } else {
                            cell.transformBack()
                        }
                    }
                }
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            case .contacts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/7),
                    heightDimension: .fractionalHeight(1)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .none, trailing: .fixed(15), bottom: .none)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                section.boundarySupplementaryItems = [headerCItem]
                
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
            case .contacts:
                if(indexPath.row == 0) {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.reuseIdentifier, for: indexPath) as? ContactCollectionViewCell
                    cell?.configureAdd()
                    
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.reuseIdentifier, for: indexPath) as? ContactCollectionViewCell
                    
                    return cell
                }
            default:
                fatalError("Pizdets")
            }
           
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case "Header":
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: CardHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! CardHeaderCollectionReusableView
                
                return headerView
            case "HeaderContact":
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "HeaderContact", withReuseIdentifier: ContactHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! ContactHeaderCollectionReusableView
                
                return headerView
            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.cards, .contacts])
        snapshot.appendItems(displayedCards, toSection: .cards)
        snapshot.appendItems(displayedContacts, toSection: .contacts)
        sections = snapshot.sectionIdentifiers
        dataSource?.apply(snapshot)
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeSceneDisplayLogic {
    func displayContent(viewModel: HomeInfo.ShowInfo.ViewModel) {
        self.displayedCards = viewModel.displayedCards
        self.displayedContacts = viewModel.displayedContact
        // addContact Button
        self.displayedContacts.insert(HomeInfo.ShowInfo.ViewModel.DisplayedContact(id: 0), at: 0)
        configureDataSource()
    }
}

