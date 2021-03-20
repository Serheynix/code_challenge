//
//  DetailView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct DetailView: View {
    var cardDetail: CardDetail
    
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            ScrollView([.vertical], showsIndicators: false) {
                VStack {
                    CardView(style: .light, name: cardDetail.name, balanceText: "Avaible balance", icon: cardDetail.icon, timeLeft: cardDetail.updated, balance: cardDetail.avaible.balance, spent: cardDetail.avaible.spent, income: cardDetail.avaible.income, withAnimate: false, onUpdate: {
                        print("\(cardDetail.name) card update clicked")
                    })
                    Divider().frame(width: 250)
                    CardView(style: .light, name: "Choice", balance: cardDetail.choice.balance, spent: cardDetail.choice.spent, income: cardDetail.choice.income)
                    Divider().frame(width: 250)
                    CardView(style: .light, name: "Savings", balance: cardDetail.saving.balance, spent: cardDetail.saving.spent, income: cardDetail.saving.income)
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("CardSecondary"), Color("CardPrimary")]),
                                           startPoint: .leading, endPoint: .trailing))
                .cornerRadius(25)
                .frame(width: 350)
                .shadow(color: Color("CardShadow"), radius: 10)
                .padding(.top, 70)
            }
        )
    }
}
