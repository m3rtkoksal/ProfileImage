//
//  MainProfile.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct MainProfile: View {
    // MARK: - Properties
    @StateObject private var viewModel = MainProfilePhotoMenuViewModel()
    @State private var choosenItem = CUIDropdownItemModel(id: "", iconName: "", text: "")
    @State private var showMainProfilePhotoMenu = false
    @StateObject var model = CameraModel()
    @State private var selectedView: AnyView? = nil
    @State private var isShowingPicker = false
    @State private var selectedImage: UIImage?
    @State private var goToPhotoEdit = false
    
    var body: some View {
        BaseView(currentViewModel: viewModel) {
            NavigationLink(
                destination: ProfilePhotoCameraView(),
                isActive: $viewModel.goToCapturePhoto
            ) {}
            NavigationLink(
                destination: ImagePickerView(selectedImage: $selectedImage, goToPhotoEdit: $goToPhotoEdit),
                isActive: $viewModel.goToGallery
            ) {}
            ZStack {
                VStack {
                    CUIProfileView(isSmallCameraIconVisible: true, imageName: ProfileManager.shared.user.profileImage, type: .small)
                        .onTapGesture {
                            self.showMainProfilePhotoMenu = true
                        }
                        .padding(.top, 28)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                viewModel.fetchMenuItems()
                //if not cleared can not detect onChange when turned back from the ProfilePhotoCameraView without capturing a photo
                choosenItem = CUIDropdownItemModel(id: "", iconName: "", text: "")
            }
            // MARK: - Profile Photo Menu
            .ndDropdownModifier(itemList: $viewModel.menuPickerItems,
                                isExpanded: $showMainProfilePhotoMenu,
                                choosenItem: $choosenItem)
            .onChange(of: choosenItem) { newValue in
                switch newValue.text {
                case "Capture Photo":
                    viewModel.goToCapturePhoto = true
                case "Select from gallery":
                    viewModel.goToGallery = true
                case "Delete Photo":
                    ProfileManager.shared.deleteProfilePicture()
                    //to change menu items dynamically (hide show delete menu item)
                    viewModel.fetchMenuItems()
                    viewModel.goToMainProfile = true
                default:
                    break
                }
            }
        }
        .navigationBarTitle("Main Profile")
    }
}
