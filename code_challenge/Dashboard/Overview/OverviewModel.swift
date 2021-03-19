//
//  OverviewModel.swift
//  code_challenge
//
//  Created by Serhii Semenov on 19.03.2021.
//

import Foundation
import Combine

struct Card: Codable {
    var balance: Int {
        get { income - spent }
    }
    var spent: Int
    var income: Int
}

struct CardDetail: Codable {
    var name: String
    var updated: Int // timestamp
    var avaible: Card
    var choice: Card
    var saving: Card
}

struct TotalCard: Codable {
    var balance: Int {
        get { cash - bills }
    }
    var bills: Int
    var cash: Int
}

struct AllAccounts {
    var totalBalance: TotalCard?
    var cards: [CardDetail]
}

struct CardInteractor {
    
    func loadCards() -> PassthroughSubject<AllAccounts, Error> {
        let publisher = PassthroughSubject<AllAccounts, Error>()
        
        // simulate WebApi delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1 sec delay
            publisher.send(
                AllAccounts(
                    totalBalance: TotalCard(bills: 300, cash: 1005),
                    cards:
                        [CardDetail(
                        name: "Westpac",
                        updated: 5*3600, // Date.now ?
                        avaible: Card(spent: 605, income: 900),
                        choice: Card(spent: 100, income: 500),
                        saving: Card(spent: 12, income: 300)
                    ), CardDetail(
                        name: "Commbank",
                        updated: 0,  // Date.now ?
                        avaible: Card(spent: 0, income: 149),
                        choice: Card(spent: 100, income: 500),
                        saving: Card(spent: 12, income: 300)
                    )]
                ))
        }
        
        return publisher
    }
}