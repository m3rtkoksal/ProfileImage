//
//  BaseViewModel.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var showIndicator = false
    @Published var hasPopup = false
}
