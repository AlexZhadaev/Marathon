//
//  RootViewController.swift
//  EggTimer
//
//  Created by Жадаев Алексей on 26.01.2023.
//

import AVFoundation
import UIKit

final class RootViewController: UIViewController {
    //MARK: Private properties
    private let eggTimings: [String: Float] = ["Soft": 300, "Medium": 420, "Hard": 720]
    private var cookingTime: Float = 0
    private var timePassed: Float = 0
    private var alarm = AVAudioPlayer()
    private var timer = Timer()
    private let titleView = UIView.makeView()
    private let titleLabel = UILabel.makeLabel()
    private let timerView = UIView.makeView()
    private let progressView = UIProgressView.makeProgressView()
    private let softEggView = UIView.makeView()
    private let softEggImageView = UIImageView.makeImageView(withImage: "soft_egg")
    private let softEggButton = UIButton.makeButton(withHardness: .soft)
    private let mediumEggView = UIView.makeView()
    private let mediumEggImageView = UIImageView.makeImageView(withImage: "medium_egg")
    private let mediumEggButton = UIButton.makeButton(withHardness: .medium)
    private let hardEggView = UIView.makeView()
    private let hardEggImageView = UIImageView.makeImageView(withImage: "hard_egg")
    private let hardEggButton = UIButton.makeButton(withHardness: .hard)
    
    private lazy var eggStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [softEggView, mediumEggView, hardEggView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, eggStackView, timerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 39
        return stackView
    }()
   //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 203/255, green: 242/255, blue: 252/255, alpha: 1)
        setupView()
        
    }
    
    //MARK: Private methods
    @objc private func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle, let timing = eggTimings[hardness] else { return }
        timer.invalidate()
        progressView.progress = 0
        timePassed = 0
        titleLabel.setTitle(hardness, for: .normal)
        cookingTime = timing
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if timePassed < cookingTime {
            timePassed += 1
            let boilPercent = timePassed / cookingTime
            progressView.progress = boilPercent
        } else {
            titleLabel.setTitle("Done", for: .normal)
            alarmRing()
            timer.invalidate()
        }
    }
    
    private func alarmRing() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            alarm = try AVAudioPlayer(contentsOf: url)
            alarm.play()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func setupView() {
        titleView.addSubview(titleLabel)
        softEggView.addSubview(softEggImageView)
        softEggImageView.addSubview(softEggButton)
        mediumEggView.addSubview(mediumEggImageView)
        mediumEggImageView.addSubview(mediumEggButton)
        hardEggView.addSubview(hardEggImageView)
        hardEggImageView.addSubview(hardEggButton)
        timerView.addSubview(progressView)
        view.addSubview(verticalStackView)
        softEggButton.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        mediumEggButton.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        hardEggButton.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            
            softEggButton.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor),
            softEggButton.topAnchor.constraint(equalTo: softEggView.topAnchor),
            softEggButton.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor),
            softEggButton.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor),
            softEggImageView.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor),
            softEggImageView.topAnchor.constraint(equalTo: softEggView.topAnchor),
            softEggImageView.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor),
            softEggImageView.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor),
            
            mediumEggButton.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor),
            mediumEggButton.topAnchor.constraint(equalTo: mediumEggView.topAnchor),
            mediumEggButton.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor),
            mediumEggButton.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor),
            mediumEggImageView.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor),
            mediumEggImageView.topAnchor.constraint(equalTo: mediumEggView.topAnchor),
            mediumEggImageView.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor),
            mediumEggImageView.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor),
            
            hardEggButton.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor),
            hardEggButton.topAnchor.constraint(equalTo: hardEggView.topAnchor),
            hardEggButton.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor),
            hardEggButton.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor),
            hardEggImageView.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor),
            hardEggImageView.topAnchor.constraint(equalTo: hardEggView.topAnchor),
            hardEggImageView.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor),
            hardEggImageView.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor),
            
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}

