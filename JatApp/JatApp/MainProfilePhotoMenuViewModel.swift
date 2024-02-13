//
//  MainProfilePhotoMenuViewModel.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import Foundation
import SwiftUI
import PhotosUI
import CoreTransferable

class MainProfilePhotoMenuViewModel: BaseViewModel {
    @Published var goToProfileDetail = false
    @Published var goToSettings = false
    @Published var goToCampaigns = false
    @Published var goToHelp = false
    @Published var menuPickerItems:[CUIDropdownItemModel] = []
    @Published var goToCapturePhoto = false
    @Published var goToGallery = false
    @Published var goToContacts = false
    @Published var selectedImage = Image("")
    @Published var goToMainProfile = false
    @Published var goToPhotoEdit = false
    
    func fetchMenuItems() {
        if ProfileManager.shared.user.profileImageEmpty {
            self.menuPickerItems = [
                CUIDropdownItemModel(id: "0", iconName: "camera", text: "Capture Photo", hasArrow: true), //ProfilePhotoCameraView
                CUIDropdownItemModel(id: "1", iconName: "gallery", text: "Select from gallery", hasArrow: true)
            ]
        } else {
            self.menuPickerItems = [
                CUIDropdownItemModel(id: "0", iconName: "camera", text: "Capture Photo", hasArrow: true), //ProfilePhotoCameraView
                CUIDropdownItemModel(id: "1", iconName: "gallery", text: "Select from gallery", hasArrow: true),
                CUIDropdownItemModel(id: "2", iconName: "trash", text: "Delete Photo", hasArrow: true) //MainProfile()
            ]
        }
    }
}

