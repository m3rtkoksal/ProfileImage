//
//  ProfilePhotoCameraViewModel.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import Foundation
import UIKit

class ProfilePhotoCameraViewModel : BaseViewModel {
    @Published var goToPhotoEdit = false
    @Published var image : UIImage?
}
