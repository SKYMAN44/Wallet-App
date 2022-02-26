//
//  HomeViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 26.02.2022.
//

import UIKit

protocol HomeSceneDisplayLogic: AnyObject {
    func displayContent()
}

final class HomeViewController: UIViewController {
    enum Section: Hashable {
        case cards
        case contacts
        case history
    }

    private var sections = [Section]()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    var interactor: (HomeBusinessLogic & HomeDataStore)?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [.cards, .contacts]
        setupCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
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
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(300)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
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

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeSceneDisplayLogic {
    func displayContent() {
    }
}
