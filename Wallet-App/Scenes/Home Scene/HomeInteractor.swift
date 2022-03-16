//
//  HomeInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

final class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker = HomeWorker(service: FileService())
    
    //MARK: - HomeDataStore
    var cards = [Cards]() {
        didSet {
            callPresenter()
        }
    }
    var contacts = [Contacts]() {
        didSet {
            callPresenter()
        }
    }
    var history = [Expenses]() {
        didSet {
            callPresenter()
        }
    }
}

extension HomeInteractor: HomeBusinessLogic {
    func showInformation(request: HomeInfo.ShowInfo.Request) {
        self.worker.getCards { (cards) in
            self.cards = cards
        }
        let contacts = self.worker.getContacts()
        let history = self.worker.getHistory()
        
        self.contacts = contacts
        self.history = history
    }
    
    private func callPresenter() {
        let response = HomeInfo.ShowInfo.Response(
            cards: self.cards,
            contacts: self.contacts,
            history: self.history
        )
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.presentData(response: response)
        }
    }
}
