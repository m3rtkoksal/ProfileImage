//
//  CUIProfileView.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

enum ProfileViewType {
    case large
    case small
    
    var textColor: Color {
        switch self {
        case .small, .large:
            return .otherBlack
        }
    }
    
    var imageWidth: CGFloat {
        switch self {
        case .small:
            return 120.0
        case .large:
            return 169.0
        }
    }
    
}

struct CUIProfileView: View {
    var isSmallCameraIconVisible: Bool = false
    var imageName: UIImage?
    var type: ProfileViewType
        
    var body: some View {
        VStack (alignment: .center, spacing:16) {
            ZStack {
                Image(uiImage: imageName ?? UIImage(imageLiteralResourceName: "profile-circle"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: type.imageWidth, height: type.imageWidth)
                .clipped()
                .cornerRadius(type.imageWidth)
                if isSmallCameraIconVisible {
                    ZStack {
                        Circle()
                            .foregroundColor(.lightPurple100)
                            .frame(width: 32, height: 32)
                        Image("camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 19, height: 19)
                    }
                    .padding(.leading,type.imageWidth * 0.8)
                    .padding(.top, type.imageWidth * 0.73)
                }
            }
        }
        .padding()
    }
}
