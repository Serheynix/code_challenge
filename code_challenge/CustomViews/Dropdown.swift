//
//  Dropdown.swift
//  code_challenge
//
//  Created by Serhii Semenov on 18.03.2021.
//

import SwiftUI

struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }

    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var val: String
    var key: String
    var onSelect: ((_ key: String) -> Void)?

    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(self.key)
            }
        }) {
            Text(self.val).fontWeight(.medium).foregroundColor(Color("TextHeader"))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(self.options, id: \.self) { option in
                DropdownOptionElement(val: option.val, key: option.key, onSelect: self.onSelect)
            }
        }

        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct DropdownButton: View {
    @State var shouldShowDropdown = false
    @State var displayText: String
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?

    let buttonHeight: CGFloat = 30
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
        }) {
            HStack {
                Text(displayText).fontWeight(.medium).foregroundColor(Color("TextHeader"))
                Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down").colorMultiply(Color("TextHeader"))
            }
        }
        .padding(.horizontal)
        .cornerRadius(15)
        .frame(width: 140, height: self.buttonHeight)
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: self.options, onSelect: { key in
                        self.shouldShowDropdown.toggle()
                        if let onSelect = self.onSelect {
                            options.forEach { (item) in
                                if (item.key == key) {
                                    displayText = item.val
                                }
                            }
                            onSelect(key)
                        }
                    })
                }
            }, alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 15).fill(Color.white)
        )
    }
}
