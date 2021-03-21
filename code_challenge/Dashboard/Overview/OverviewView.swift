//
//  OverviewView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct MoneyCategory: View {
    var name: String
    var amount: Int
    var icon: String
    var onSelect: ((_ key: String) -> Void)?

    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(self.name)
            }
        }) {
            VStack {
                Image(icon)
                Text(name).font(.footnote).foregroundColor(Color("TextSubtitle")).padding(.bottom, 1).padding(.top, 10)
                Text("$\(amount)").font(.footnote).foregroundColor(Color("TextTitle")).fontWeight(.bold)
            }
        }
        .padding(10)
    }
}

struct OverviewView: View {
    // money_category click
    private static let onSelect = { key in
        print(key)
    }
    
    @State private var showDetail = false
    @State private var shoosedCard = "All"
    @State var animate = false
    @ObservedObject var presenter = CardPresenter()
    
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            ZStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Text("Home").font(.title).fontWeight(.bold).foregroundColor(Color("TextHeader")).padding(.leading)
                        Spacer()
                    }.padding(.vertical, 25)
                    
                    if (presenter.isLoadingData) {
                    
                        PagesContainer(contentCount: presenter.allAccounts.cards.count + 1) {
                            // All accounts
                            if let totalBalance = presenter.allAccounts.totalBalance {
                                CardView(style: .blue, hasAllAccounts: true, name: "All accounts", balanceText: "Balance after bills", balance: totalBalance.balance, spent: totalBalance.bills, income: totalBalance.cash)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("AllCardsSecondary"), Color("AllCardsPrimary")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25).shadow(color: Color("CardShadow"), radius: 15)
                                .gesture(
                                    TapGesture().onEnded { _ in
                                        shoosedCard = "All accounts"
                                        self.showDetail.toggle()
                                    }
                                )
                            }
                            
                            ForEach(presenter.allAccounts.cards) { cardDetail in
                                CardView(style: .light, name: cardDetail.name, balanceText: "Avaible balance", icon: cardDetail.icon, timeLeft: cardDetail.updated, balance: cardDetail.avaible.balance, spent: cardDetail.avaible.spent, income: cardDetail.avaible.income, onUpdate: {
                                    print("Westpac update clicked")
                                })
                                .background(LinearGradient(gradient: Gradient(colors: [Color("CardSecondary"), Color("CardPrimary")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25).shadow(color: Color("CardShadow"), radius: 15)
                                .gesture(
                                    TapGesture().onEnded { _ in
                                        shoosedCard = cardDetail.name
                                        self.showDetail.toggle()
                                    }
                                )
                            }
                            
                        }.frame(width: 320, height: 250)
                        
                    } else {
                        VStack(alignment: .center) {
                            ProgressView().progressViewStyle(CircularProgressViewStyle()).transformEffect(.init(scaleX: 1.5, y: 1.5))
                        }.frame(width: 320, height: 250)
                    }
                    
                    HStack(alignment: .center) {
                        Text("Money spent").font(.title3).fontWeight(.bold).foregroundColor(Color("TextHeader")).padding(.leading)
                        Spacer()
                        Button("View all", action: {
                            print("View all clicked!")
                        }).padding(.trailing)
                    }
                    HStack {
                        MoneyCategory(name: "Groceries", amount: 653, icon: "ic_money_category_grocery", onSelect: OverviewView.onSelect)
                        MoneyCategory(name: "Restaurants", amount: 405, icon: "ic_money_category_restaurant_cafe", onSelect: OverviewView.onSelect)
                        MoneyCategory(name: "Household", amount: 201, icon: "ic_money_category_household", onSelect: OverviewView.onSelect)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))

                    Spacer()
                }
                
                if showDetail {
                    Color("Background").edgesIgnoringSafeArea(.all).overlay(
                        ScrollView([.vertical], showsIndicators: false) {
                            let gradColor = shoosedCard == "All accounts" ?
                                [Color("AllCardsSecondary"), Color("AllCardsPrimary")] :
                                [Color("CardSecondary"), Color("CardPrimary")]
                            VStack {
                                if (shoosedCard == "All accounts") {
                                    // All accounts
                                    if let totalBalance = presenter.allAccounts.totalBalance {
                                        CardView(style: .blue, hasAllAccounts: true, name: "All accounts", balanceText: "Balance after bills", balance: totalBalance.balance, spent: totalBalance.bills, income: totalBalance.cash, withAnimate: false)
                                        Divider().frame(width: 250)
                                    }
                                    
                                    if (animate) {
                                        ForEach(presenter.allAccounts.cards) { cardDetail in
                                            CardView(style: .blue, name: cardDetail.name, balanceText: "Avaible balance", icon: cardDetail.icon, timeLeft: cardDetail.updated, balance: cardDetail.avaible.balance, spent: cardDetail.avaible.spent, income: cardDetail.avaible.income, onUpdate: {
                                                print("Westpac update clicked")
                                            })
                                            Divider().frame(width: 250)
                                        }
                                    }
                                } else {
                                    if let cardDetail = presenter.allAccounts.cards.first(where: {$0.name == shoosedCard}) {
                                        CardView(style: .light, name: cardDetail.name, balanceText: "Avaible balance", icon: cardDetail.icon, timeLeft: cardDetail.updated, balance: cardDetail.avaible.balance, spent: cardDetail.avaible.spent, income: cardDetail.avaible.income, withAnimate: false, onUpdate: {
                                            print("\(cardDetail.name) card update clicked")
                                        })
                                        if (animate) {
                                            Divider().frame(width: 250)
                                            CardView(style: .light, name: "Choice", balance: cardDetail.choice.balance, spent: cardDetail.choice.spent, income: cardDetail.choice.income)
                                            Divider().frame(width: 250)
                                            CardView(style: .light, name: "Savings", balance: cardDetail.saving.balance, spent: cardDetail.saving.spent, income: cardDetail.saving.income)
                                        }
                                    }
                                }
                            }
                            .background(LinearGradient(gradient: Gradient(colors: gradColor),
                                                       startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(25)
                            .frame(width: 350)
                            .shadow(color: Color("CardShadow"), radius: 10)
                            .padding(.top, 70)
                            .onAppear {
                                withAnimation(.linear(duration: 1)) {
                                    animate = true
                                }
                            }
                        }
                    )
                    VStack {
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 1)) {
                                    animate = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showDetail.toggle()
                                }
                            } label: {
                                Image(systemName: "chevron.left").foregroundColor(Color("TextHeader")).padding(.horizontal)
                            }
                            Text(shoosedCard).font(.title3).fontWeight(.bold).foregroundColor(Color("TextHeader"))
                            Spacer()
                        }.padding(.vertical, 25)
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        DropdownButton(displayText: "Monthly", options: [
                                        DropdownOption(key: "day", val: "Daily"),
                                        DropdownOption(key: "month", val: "Monthly"),
                                        DropdownOption(key: "year", val: "Yearly")],
                                       onSelect: { key in
                                            print(key)
                                       })
                        .padding([.top, .trailing])
                    }
                    Spacer()
                }
            }
        )
    }
}
