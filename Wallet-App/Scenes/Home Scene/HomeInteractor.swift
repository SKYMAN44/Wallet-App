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
    public func showInformation(request: HomeInfo.ShowInfo.Request) {
        self.worker.getCards { (cards) in
            self.cards = cards
            self.history = cards[0].history ?? []
        }
        let contacts = self.worker.getContacts()
        self.contacts = contacts
    }
    
    public func showCardHistory(request: HomeInfo.ShowInfo.Request) {
        if let index = request.cardIndex {
            self.history = self.cards[index].history ?? []
        }
    }
    
    private func callPresenter() {
        let response = HomeInfo.ShowInfo.Response(
            cards: self.cards,
            contacts: self.contacts,
            history: sortedHistory(self.history)
        )
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.presentData(response: response)
        }
    }
    
    private func sortedHistory(_ history: [Expenses]) -> [Expenses] {
        var sortedHistory = history.filter { $0.date.compare(DateFilters.startOfToday) == .orderedDescending }
        sortedHistory.sort(by: { $0.date > $1.date })
        
        return sortedHistory
    }
}
