//
//  BaseView.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

enum BaseViewBackgroundType{
    case purpleImage
    case grayColor
    case red
    case solidWhite
    case transparent
    case darkGray
}

struct BaseView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var currentViewModel: BaseViewModel
    @State var isSuccess = true
    var background: BaseViewBackgroundType
    var hideBackButton: Bool
    let content: Content
    
    init(
         currentViewModel: BaseViewModel,
         background: BaseViewBackgroundType? = nil,
         hideBackButton: Bool? = false,
         @ViewBuilder content: () -> Content)
    {
        self.currentViewModel = currentViewModel
        self.background = background ?? .solidWhite
        self.hideBackButton = hideBackButton ?? false
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.darkPurple
                .ignoresSafeArea()
            switch background {
            case .darkGray:
                Color.solidGray
                        .ignoresSafeArea()
            case .purpleImage:
                Image("morparaPurpleBackground")
                    .resizable()
                    .ignoresSafeArea()
            case .grayColor:
                Color.CF6F7F6
                    .ignoresSafeArea()
            case .solidWhite:
                    Color.solidWhite
                        .ignoresSafeArea()
            case .red:
                Color.red
                    .ignoresSafeArea()
            case .transparent:
                    Color.clear
                        .ignoresSafeArea()
                
            }
            
            // CONTENT
    
            content
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
