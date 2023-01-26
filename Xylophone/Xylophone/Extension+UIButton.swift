//
//  Extension+UIButton.swift
//  Xylophone
//
//  Created by Жадаев Алексей on 25.01.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

extension UIButton {
    static func customButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40.0)
        return button
    }
}
