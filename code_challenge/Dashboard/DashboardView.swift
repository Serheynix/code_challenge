//
//  DashboardView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 17.03.2021.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabBarView(pages: .constant([TabBarPage(page: OverviewView(), icon: "tab-overview", tag: 0),
                                     TabBarPage(page: BudgetView(), icon: "tab-budget", tag: 1),
                                     TabBarPage(page: LendView(), icon: "tab-lend", tag: 2),
                                     TabBarPage(page: ProfileView(), icon: "tab-profile", tag: 3)]))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
