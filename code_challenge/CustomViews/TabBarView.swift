//
//  TabBarView.swift
//  code_challenge
//
//  Created by Serhii Semenov on 17.03.2021.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab = 0
    @Binding var pages: [TabBarPage]
    init(pages: Binding<[TabBarPage]>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        
                        .tabItem{
                            EmptyView()
                        }
                        .tag(item.tag)
                }
            }
            
            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                    }) {
                        ZStack {
                            Image(item.icon)
                                .foregroundColor(self.selectedTab == item.tag ? Color("TextHeader") : Color.gray)
                                .padding(7)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(5)
            .background(Color.white)
            .cornerRadius(50)
            .padding()
        }
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: Int
}
