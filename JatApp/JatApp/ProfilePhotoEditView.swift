//
//  ProfilePhotoEditView.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

import Mantis
import SwiftUI

struct ProfilePhotoEditView: View {
    @StateObject private var vm = ProfilePhotoCameraViewModel()
    @StateObject var model = CameraModel()
    @State private var showingCropper = false
    @State private var showingCropShapeList = false
    @State private var contentHeight: CGFloat = 0
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    @State private var cropperType: ImageCropperType = .normal
    @Binding var capturedImage: UIImage?
    @State var croppedImage: UIImage?
    var body: some View {
        NavigationLink(
            destination: MainProfile(),
            isActive: $showingCropper
        ) {}
            VStack(spacing: 0) {
                ImageCropper(image: $capturedImage,
                             cropShapeType: $cropShapeType,
                             presetFixedRatioType: $presetFixedRatioType,
                             type: $cropperType,
                             goToMainProfile: $showingCropper)
                .onDisappear(perform: reset)
                .ignoresSafeArea()
            }
        
       
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            vm.showIndicator = false
        }
    }
    func reset() {
        cropShapeType = .rect
        presetFixedRatioType = .canUseMultiplePresetFixedRatio()
        cropperType = .normal
    }
}
