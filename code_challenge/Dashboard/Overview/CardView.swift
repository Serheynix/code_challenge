//
//  CardView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

// helper func
func timeAgo(time: Int) -> String {
    var ret: String
    if (time == 0) {
        ret = "now"
    } else if (time > 0 && time < 60) {
        ret = "\(time) seconds ago"
    } else if (time > 60 && time < 3600) {
        ret = "\(time/60) minutes ago"
    } else if (time > 3600 && time < 3600*24) {
        ret = "\(time/3600) hours ago"
    } else if (time > 3600*24 && time < 3600*24*365) {
        ret = "\(time/(3600*24)) days ago"
    } else {
        ret = "\(time/(3600*24*365)) years ago"
    }
    return ret
}

enum CardStyle {
    case light, blue
}

struct CardView: View {
    var style: CardStyle
    var hasAllAccounts = false
    var name: String
    var balanceText: String?
    var icon: String?
    var timeLeft: Int?
    var balance: Int
    var spent: Int
    var income: Int
    var onUpdate: ( () -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let icon = self.icon {
                    Image(icon).resizable().frame(width: 20, height: 20).fixedSize()
                        .frame(width: 30, height: 30).background(Color.white).clipShape(Circle())
                }
                Text("\(name)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(style == .light ? "TextHeader" : "CardSecondary"))
                Spacer()
                Button(action: {
                    if let onUpdate = self.onUpdate {
                        onUpdate()
                    }
                }, label: {
                    if let timeLeft = self.timeLeft {
                        Image(systemName: "arrow.clockwise").foregroundColor(Color(style == .light ? "TextSubtitle" : "CardPrimary"))
                        Text(timeAgo(time: timeLeft))
                            .font(.footnote)
                            .foregroundColor(Color(style == .light ? "TextSubtitle" : "CardPrimary"))
                    }
                })
            }
            .padding(.all)
            HStack {
                Text("$\(balance)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(style == .light ? "TextHeader" : "CardSecondary"))
                if let balanceText = self.balanceText {
                    Text(balanceText)
                        .font(.footnote)
                        .foregroundColor(Color(style == .light ? "TextSubtitle" : "CardPrimary"))
                }
            }
            .padding(.horizontal)
            Spacer()
            HStack {
                if (hasAllAccounts) {
                    LinearGradient(gradient: Gradient(colors: [Color("CardSpent"), Color("CardSpent2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    LinearGradient(gradient: Gradient(colors: [Color("CardIncome"), Color("CardIncome2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color("CardIncome"), Color("CardIncome2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    LinearGradient(gradient: Gradient(colors: [Color("CardSpent"), Color("CardSpent2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(height: 10)
            .padding(.horizontal)
            HStack {
                Circle().frame(width: 10, height: 10).foregroundColor(Color("CardSpent"))
                Text("$\(spent)")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color(style == .light ? "TextHeader" : "CardSecondary"))
                Text(hasAllAccounts ? "Bills" : "Spent")
                    .font(.footnote)
                    .foregroundColor(Color(style == .light ? "TextHeader" : "CardSecondary"))
                Spacer()
                Circle().frame(width: 10, height: 10).foregroundColor(Color("CardIncome"))
                Text("$\(income)")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color(style == .light ? "TextHint" : "CardSecondary"))
                Text(hasAllAccounts ? "Cash" : "Income")
                    .font(.footnote)
                    .foregroundColor(Color(style == .light ? "TextHint" : "CardSecondary"))
            }
            .padding(.all)
        }
        .frame(width: 300, height: 180.0)
    }
}
