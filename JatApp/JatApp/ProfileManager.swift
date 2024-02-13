//
//  ProfileManager.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import Foundation
import Combine
import UIKit

final class ProfileManager: ObservableObject {
    static let shared = ProfileManager()
    @Published private(set) var user: UserProfileModel

    var userPublisher: AnyPublisher<UserProfileModel, Never> {
        $user.eraseToAnyPublisher()
    }
    
    private init() {
        user = UserProfileModel()
    }
    
    func setProfilePicture(_ image: UIImage) {
        self.user.profileImage = image
        self.user.profileImageEmpty = false
    }
    func deleteProfilePicture() {
        self.user.profileImage = UIImage(named: "profile-circle")
        self.user.profileImageEmpty = true
    }
}

final class UserProfileModel: Equatable, ObservableObject {
    
    static func ==(lhs: UserProfileModel, rhs: UserProfileModel) -> Bool {
        // Define the logic for comparing two UserProfileModel instances here
        // You need to compare all relevant properties to determine equality
        return lhs.profileImage == rhs.profileImage && lhs.profileImage == rhs.profileImage // Add more properties as needed
    }
    
    var profileImage: UIImage?
    var profileImageEmpty: Bool = true
    
    @Published var notificationCount: Int = 0
    var isUserLoggedIn = false
}
