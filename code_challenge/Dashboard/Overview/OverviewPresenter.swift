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
    
    init() {
        canselableSet.insert(interactor.loadCards().sink { err in
            print(err)
            self.isLoadingData = false
        } receiveValue: { cards in
            self.isLoadingData = true
            self.allAccounts = cards
        })
    }
}
