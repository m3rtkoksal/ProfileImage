//
//  NavigationUtıil.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import UIKit

struct NavigationUtil {
    static func popToRootView(animated: Bool = true) {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: animated)
    }
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}

