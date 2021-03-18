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
    
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            ZStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Text("Home").font(.title).fontWeight(.bold).foregroundColor(Color("TextHeader")).padding(.leading)
                        Spacer()
                    }.padding(.vertical, 25)
                    
                    PagesContainer(contentCount: 3) {
                        
                        CardView(style: .blue, hasAllAccounts: true, name: "All accounts", balanceText: "Balance after bills", balance: 705, spent: 300, income: 1005)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("AllCardsSecondary"), Color("AllCardsPrimary")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25).shadow(color: Color("CardShadow"), radius: 15)
                        .gesture(
                            TapGesture().onEnded { _ in
                                shoosedCard = "All accounts"
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.showDetail.toggle()
                                }
                            }
                        )
                        
                        CardView(style: .light, name: "Westpac", balanceText: "Avaible balance", icon: "ic_westpac", timeLeft: 5*3600, balance: 295, spent: 605, income: 900, onUpdate: {
                            print("Westpac update clicked")
                        })
                        .background(LinearGradient(gradient: Gradient(colors: [Color("CardSecondary"), Color("CardPrimary")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25).shadow(color: Color("CardShadow"), radius: 15)
                        .gesture(
                            TapGesture().onEnded { _ in
                                shoosedCard = "Westpac"
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.showDetail.toggle()
                                }
                            }
                        )
                        
                        CardView(style: .light, name: "Commbank", balanceText: "Avaible balance", icon: "ic_commbank", timeLeft: 0, balance: 149, spent: 0, income: 149, onUpdate: {
                            print("Commbank update clicked")
                        })
                        .background(LinearGradient(gradient: Gradient(colors: [Color("CardSecondary"), Color("CardPrimary")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25).shadow(color: Color("CardShadow"), radius: 15)
                        .gesture(
                            TapGesture().onEnded { _ in
                                shoosedCard = "Commbank"
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.showDetail.toggle()
                                }
                            }
                        )
                        
                    }.frame(width: 320, height: 250)
                    
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
                    DetailView(name: shoosedCard, style: shoosedCard == "All accounts" ? .blue : .light)
                    VStack {
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 1)) {
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
