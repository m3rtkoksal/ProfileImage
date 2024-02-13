//
//  NDDropdownModifier.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct NDDropdownModifier: ViewModifier {
    @Binding var itemList: [CUIDropdownItemModel]
    @Binding var isExpanded: Bool
    @Binding var choosenItem: CUIDropdownItemModel
    var isSearchBarEnabled: Bool = false
    var searchText: String = ""
    var buttonAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isExpanded)
            if isExpanded {
                BackgroundBlurView(style: .dark)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isExpanded = false
                        }
                    }
            }
            if isExpanded {
                VStack {
                    Spacer()
                    CUIDropdown(
                        itemList: $itemList,
                        choosenItem: $choosenItem,
                        isExpanded: $isExpanded,
                        isSearchBarEnabled: isSearchBarEnabled,
                        searchText: searchText
                    )
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            }
        }
    }
}

extension View {
    func ndDropdownModifier(
        itemList: Binding<[CUIDropdownItemModel]>,
        isExpanded: Binding<Bool>,
        choosenItem: Binding<CUIDropdownItemModel>,
        isSearchBarEnabled: Bool = false,
        searchText: String = "",
        buttonAction: (() -> Void)? = nil
    ) -> some View {
        modifier(NDDropdownModifier(
            itemList: itemList,
            isExpanded: isExpanded,
            choosenItem: choosenItem,
            isSearchBarEnabled: isSearchBarEnabled,
            searchText: searchText
        ))
    }
}
