//
//  UIColor+random.swift
//  TowerOfHanoi
//
//  Created by Matheus Felizola Freires on 05/11/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
