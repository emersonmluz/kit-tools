//
//  PomodoroViewController.swift
//  kit-tools
//
//  Created by Émerson M Luz on 14/04/23.
//

import UIKit
import AVFoundation

class PomodoroViewController: UIViewController {
    
    var lbTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 100)
        label.numberOfLines = 1
        label.text = "25:00"
        label.textAlignment = .center
        return label
    }()
    
    lazy var btStart: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 35)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sgControl: UISegmentedControl = {
        let items = ["Pomodoro", "Short Break", "Long Break"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .white
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(clickSgControl(_:)), for: .valueChanged)
        return segment
    }()
    
    var pomodoroMinute: Int = 24
    var pomodoroSeconds: Int = 59
    var pomodoroTime: String = ""
    var sound = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemRed
        self.navigationItem.title = "Pomodoro"
        setComponents()
        setConstraints()
        loadSound()
    }
    
    func setComponents() {
        view.addSubview(sgControl)
        view.addSubview(lbTime)
        view.addSubview(btStart)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            sgControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            sgControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sgControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sgControl.heightAnchor.constraint(equalToConstant: 40),
            
            lbTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbTime.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lbTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            btStart.topAnchor.constraint(equalTo: lbTime.bottomAnchor, constant: 50),
            btStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btStart.widthAnchor.constraint(equalToConstant: 185),
            btStart.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func loadSound() {
        do {
            let effect = Bundle.main.path(forResource: "alarm", ofType: "mp3")
            try sound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: effect!))
        } catch {
            let alert = UIAlertController(title: "Erro", message: "Arquivo de áudio não encontrado.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendi", style: .default))
        }
    }

    @objc func start(_ sender: UIButton) {
        guard sender.titleLabel?.text != "OK" else {
            sender.setTitle("Start", for: .normal)
            sound.stop()
            reset()
            return
        }
        
        if sender.titleLabel?.text == "Start" {
            sender.setTitle("Stop", for: .normal)
            sender.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 35)
        } else {
            sender.setTitle("Start", for: .normal)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
            self.time()
            if sender.titleLabel?.text == "Start" {
                timer.invalidate()
                self.reset()
            }
            if self.pomodoroMinute == 0 && self.pomodoroSeconds == -1 {
                timer.invalidate()
                sender.setTitle("OK", for: .normal)
                self.sound.play()
            }
        }
    }
    
    @objc func clickSgControl(_ sender: UISegmentedControl) {
        sound.stop()
        btStart.setTitle("Start", for: .normal)
        reset()
    }
    
    func time () {
        pomodoroTime = ""
        pomodoroTime.append(String(pomodoroMinute))
        pomodoroTime.append(":")
        
        if pomodoroSeconds >= 10 {
            pomodoroTime.append(String(pomodoroSeconds))
        } else {
            pomodoroTime.append("0")
            pomodoroTime.append(String(pomodoroSeconds))
        }
        
        lbTime.text = self.pomodoroTime
        pomodoroSeconds -= 1
        
        if pomodoroSeconds == 0 && pomodoroMinute != 0 {
            pomodoroMinute -= 1
            pomodoroSeconds = 59
        }
    }
    
    func reset () {
        switch sgControl.selectedSegmentIndex {
            case 0:
                pomodoroMinute = 24
                lbTime.text = "25:00"
            case 1:
                pomodoroMinute = 4
                lbTime.text = "5:00"
            case 2:
                pomodoroMinute = 14
                lbTime.text = "15:00"
        default:
            let alert = UIAlertController(title: "Erro", message: "Erro inesperado! Tente novamente mais tarde.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendi", style: .default))
        }
        pomodoroSeconds = 59
    }
    

}
