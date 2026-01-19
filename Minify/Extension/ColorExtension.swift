//
//  ColorExtension.swift
//  Minify
//
//  Created by Hafizur Rahman on 19/1/26.
//

import Foundation
import SwiftUI

extension Color {
    init(r: Double, g: Double, b: Double, a: Double = 1.0) {
        self.init(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            opacity: a
        )
    }
}
