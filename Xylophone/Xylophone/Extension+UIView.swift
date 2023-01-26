//
//  Extension+UIView.swift
//  Xylophone
//
//  Created by Жадаев Алексей on 26.01.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

extension UIView {
    
    static func layout(button: UIButton, withPadding padding: CGFloat) -> UIView {
        let view = UIView.makeView(color: .systemBackground)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: padding),
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
        return view
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
