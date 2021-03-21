//
//  OverviewPresenter.swift
//  code_challenge
//
//  Created by Serhii Semenov on 19.03.2021.
//

import SwiftUI
import Combine

final class CardPresenter: ObservableObject {
    @Published var allAccounts = AllAccounts(cards: [])
    @Published var isLoadingData = false
    
    private let interactor = CardInteractor()
    private var canselableSet: Set<AnyCancellable> = []
    private var configManager = ConfigManager.shared
    
    init() {
        canselableSet.insert(interactor.loadCards().sink { err in
            print(err)
            self.isLoadingData = false
        } receiveValue: { cards in
            self.isLoadingData = true
            self.allAccounts = cards
        })
    }
    
    func selectedIndex() -> Int {
        if let cardIndex = allAccounts.cards.firstIndex(where: {$0.name == selectedAccount}) {
            return cardIndex + 1
        }
        return 0
    }
 
    var selectedAccount: String {
        get {
            return configManager.selectedAccount
        }
        set {
            configManager.selectedAccount = newValue
        }
    }
}
