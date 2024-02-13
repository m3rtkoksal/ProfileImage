//
//  ImagePickerViewModel.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

class ImagePickerViewModel: BaseViewModel {
    @Published var selectedImage = Image("")
    @Published var goToPhotoEdit = false
}
