//
//  CUIDropdownElement.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct CUIDropdownElement: View {
    var item: CUIDropdownItemModel
    
    var body: some View {
        HStack {
            if let iconName = item.iconName {
                if !iconName.isEmpty {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 16)
                }
            }
            
            Text(item.text)
                .font(.subtext4)
                .foregroundColor(.textColorsPrimary)
            Spacer()
            if let hasArrow = item.hasArrow {
                    Image("simple-arrow-right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        
            }
        }
        .background(Color.solidWhite)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

struct CUIDropdownElement_Previews: PreviewProvider {
    static var previews: some View {
        CUIDropdownElement(item: CUIDropdownItemModel(iconName: "", text: "Lorem Ipsum"))
    }
}
