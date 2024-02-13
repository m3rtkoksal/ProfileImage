//
//  CUIDropDown.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct CUIDropdownItemModel: Codable, Hashable {
    var id : String?
    var iconName: String? = ""
    let text: String
    var hasArrow: Bool?
}

struct CUIDropdown: View {
    @Binding var itemList: [CUIDropdownItemModel]
    @State private var totalHeight :CGFloat = 0
    @Binding var choosenItem: CUIDropdownItemModel
    @Binding var isExpanded: Bool
    var isSearchBarEnabled: Bool
    @State var searchText: String
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .frame(width: 50, height: 4)
                    .cornerRadius(15, corners: .allCorners)
                    .foregroundColor(.gray)
                    .offset(y: 10)
                ScrollView(showsIndicators: false) {
                    ForEach(itemList.filter { searchText.isEmpty || $0.text.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                        Button {
                            withAnimation {
                                choosenItem = item
                                isExpanded = false
                            }
                        } label: {
                            CUIDropdownElement(item: item)
                        }
                        if itemList.last != item {
                            Divider()
                        }
                    }
                    .padding(.vertical, 30)
                }
                .frame(maxHeight: UIScreen.screenHeight * 0.6)
                .onPreferenceChange(ItemHeightPreferenceKey.self) { heights in
                    let topHeight: CGFloat = 57
                    let spacingHeight = CGFloat(itemList.count) * 48 // Calculate total spacing height
                    let bottomHeight: CGFloat = 18
                    totalHeight = heights.reduce(0, +) + spacingHeight + topHeight + bottomHeight
                }
            }
            .frame(maxHeight: UIScreen.screenHeight * 0.6)
            .background(Color.solidWhite)
            .cornerRadius(32, corners: [.topLeft, .topRight])
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(Color.white)
                    .padding(.bottom, -40)
            )
            .padding(.top, itemList.count > 20 ? nil : UIScreen.main.bounds.height - totalHeight-40)
        }
        .zIndex(1)
    }
}
