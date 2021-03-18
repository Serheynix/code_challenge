//
//  BudgetView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct BudgetView: View {
    var body: some View {
        Color("Background").edgesIgnoringSafeArea(.all).overlay(
            Text("The content of the second view")
        )
    }
}
