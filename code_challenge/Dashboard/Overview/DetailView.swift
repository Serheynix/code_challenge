//
//  DetailView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct DetailView: View {
    var name: String
    var style: CardStyle
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            ScrollView([.vertical], showsIndicators: false) {
                VStack {
                    CardView(style: style, name: name, balanceText: "Avaible balance", icon: "ic_westpac", timeLeft: 5*3600, balance: 295, spent: 605, income: 900, onUpdate: {
                        print("\(name) card update clicked")
                    })
                    Divider().frame(width: 250)
                    CardView(style: style, name: "Choice", balance: 400, spent: 100, income: 500)
                    Divider().frame(width: 250)
                    CardView(style: style, name: "Savings", balance: 288, spent: 12, income: 300)
                }
                .background(LinearGradient(gradient: Gradient(colors: self.style == .light ?
                    [Color("CardSecondary"), Color("CardPrimary")] : [Color("AllCardsSecondary"), Color("AllCardsPrimary")]
                ), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(25)
                .frame(width: 350)
                .shadow(color: Color("CardShadow"), radius: 10)
                .padding(.top, 70)
            }
        )
    }
}
