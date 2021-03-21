//
//  PagesContainer.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct PagesContainer <Content : View> : View {
    let contentCount: Int
    let selectedIndex: Int
    @State var index: Int = 0
    let content: Content
    @GestureState private var translation: CGFloat = 0
    
    init(contentCount: Int, selectedIndex: Int = 0, @ViewBuilder content: () -> Content) {
        self.contentCount = contentCount
        self.content = content()
        self.selectedIndex = selectedIndex
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack (spacing: 0){
                    self.content
                        .frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.index) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        var weakGesture : CGFloat = 0
                        if value.translation.width < 0 {
                            weakGesture = -100
                        } else {
                            weakGesture = 100
                        }
                        let offset = (value.translation.width + weakGesture) / geometry.size.width
                        let newIndex = (CGFloat(self.index) - offset).rounded()
                        self.index = min(max(Int(newIndex), 0), self.contentCount - 1)
                    }
                )
                HStack {
                    ForEach(0..<self.contentCount) { num in
                        if (self.index == num) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color("PageIndicator"))
                                            .frame(width: 25, height: 10)
                        } else {
                            Circle().frame(width: 10, height: 10)
                                .foregroundColor(Color("PageIndicator").opacity(0.3))
                        }
                    }
                }
                .padding(.top, 25)
            }
            .onAppear {
                self.index = selectedIndex
             }
        }
    }
}
