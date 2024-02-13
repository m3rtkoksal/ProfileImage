//
//  ItemHeightPreferenceKey.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct ItemHeightPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

