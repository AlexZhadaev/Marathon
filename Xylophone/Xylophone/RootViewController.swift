//
//  RootViewController.swift
//  Xylophone
//
//  Created by Жадаев Алексей on 24.01.2023.
//

import UIKit
import AVFoundation

final class RootViewController: UIViewController {
    
    private var player = AVAudioPlayer()
    private let c = UIButton.customButton(title: "C", backgroundColor: .systemRed)
    private let d = UIButton.customButton(title: "D", backgroundColor: .systemOrange)
    private let e = UIButton.customButton(title: "E", backgroundColor: .systemYellow)
    private let f = UIButton.customButton(title: "F", backgroundColor: .systemGreen)
    private let g = UIButton.customButton(title: "G", backgroundColor: .systemIndigo)
    private let a = UIButton.customButton(title: "A", backgroundColor: .systemBlue)
    private let b = UIButton.customButton(title: "B", backgroundColor: .systemPurple)
    
    private lazy var buttonStackView: UIStackView = {
        let c = UIView.layout(button: c, withPadding: 5)
        let d = UIView.layout(button: d, withPadding: 10)
        let e = UIView.layout(button: e, withPadding: 15)
        let f = UIView.layout(button: f, withPadding: 25)
        let g = UIView.layout(button: g, withPadding: 30)
        let a = UIView.layout(button: a, withPadding: 35)
        let b = UIView.layout(button: b, withPadding: 40)
        let stackView = UIStackView(arrangedSubviews: [c, d, e, f, g, a, b])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func playSound(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        sender.layer.opacity = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.layer.opacity = 1
        }
        playSound(of: title)
    }
    
    private func playSound(of title: String) {
        guard let path = Bundle.main.path(forResource: title, ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func setupView() {
        c.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        d.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        e.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        f.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        g.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        b.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        a.addTarget(self, action: #selector(playSound(_:)), for: .touchUpInside)
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
