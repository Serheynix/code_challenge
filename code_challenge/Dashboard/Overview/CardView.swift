//
//  CardView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

// FIXME: Fixed animation

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
    
    @State private var a: Float = 0.0
    @State private var b: Float = 0.0
    
    var body: some View {
        let cardWidth = Float(300)
        let animDuration = 2.0
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
                    LinearGradient(gradient: Gradient(colors: [Color("CardSpent"), Color("CardSpent2")]), startPoint: .leading, endPoint: .trailing).cornerRadius(3.0).frame(width: CGFloat(a))
                    LinearGradient(gradient: Gradient(colors: [Color("CardIncome"), Color("CardIncome2")]), startPoint: .leading, endPoint: .trailing).cornerRadius(3.0).frame(width: CGFloat(b))
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color("CardIncome"), Color("CardIncome2")]), startPoint: .leading, endPoint: .trailing).cornerRadius(3.0).frame(width: CGFloat(b))
                    LinearGradient(gradient: Gradient(colors: [Color("CardSpent"), Color("CardSpent2")]), startPoint: .leading, endPoint: .trailing).cornerRadius(3.0).frame(width: CGFloat(a))
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
        .frame(width: CGFloat(cardWidth), height: 180.0)
        .onAppear {
            withAnimation(.linear(duration: animDuration)) {
                a = cardWidth * Float(spent)/Float(income) * Float(0.9)
                b = cardWidth * Float(balance)/Float(income) * Float(0.9)
            }
        }
    }
}
