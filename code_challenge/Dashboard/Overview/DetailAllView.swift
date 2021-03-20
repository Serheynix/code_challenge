//
//  DetailAllView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 19.03.2021.
//

import SwiftUI

struct DetailAllView: View {
    var allAccounts: AllAccounts
    
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            ScrollView([.vertical], showsIndicators: false) {
                VStack {
                    // All accounts
                    if let totalBalance = allAccounts.totalBalance {
                        CardView(style: .blue, hasAllAccounts: true, name: "All accounts", balanceText: "Balance after bills", balance: totalBalance.balance, spent: totalBalance.bills, income: totalBalance.cash, withAnimate: false)
                        Divider().frame(width: 250)
                    }
                    
                    ForEach(allAccounts.cards) { cardDetail in
                        CardView(style: .blue, name: cardDetail.name, balanceText: "Avaible balance", icon: cardDetail.icon, timeLeft: cardDetail.updated, balance: cardDetail.avaible.balance, spent: cardDetail.avaible.spent, income: cardDetail.avaible.income, onUpdate: {
                            print("Westpac update clicked")
                        })
                        Divider().frame(width: 250)
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("AllCardsSecondary"), Color("AllCardsPrimary")]),
                                           startPoint: .leading, endPoint: .trailing))
                .cornerRadius(25)
                .frame(width: 350)
                .shadow(color: Color("CardShadow"), radius: 10)
                .padding(.top, 70)
            }
        )
    }
}
