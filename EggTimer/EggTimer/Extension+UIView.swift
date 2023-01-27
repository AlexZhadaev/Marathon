//
//  Extension+UIView.swift
//  EggTimer
//
//  Created by Жадаев Алексей on 27.01.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit
//MARK: HardnessEnum
enum EggHardness{
    case soft
    case medium
    case hard
}

//MARK: UIView
extension UIView {
    static func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

//MARK: UIImageView
extension UIImageView {
    static func makeImageView(withImage image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

//MARK: UIButton
extension UIButton {
    static func makeButton(withHardness hardness: EggHardness) -> UIButton {
        let title: String = {
            switch hardness {
            case .soft:
                return "Soft"
            case .medium:
                return "Medium"
            case .hard:
                return "Hard"
            }
        }()
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        return button
    }
}

//MARK: UILabel
extension UILabel {
    static func makeLabel() -> UIButton {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.setTitle("How do you like your eggs?", for: .normal)
        label.setTitleColor(.darkGray, for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        return label
    }
}

//MARK: UIProgressView
extension UIProgressView {
    static func makeProgressView() -> UIProgressView {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .systemYellow
        view.trackTintColor = .systemGray
        view.progress = 0.0
        return view
    }
}
