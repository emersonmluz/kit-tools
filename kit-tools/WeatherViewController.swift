//
//  WeatherViewController.swift
//  kit-tools
//
//  Created by Émerson M Luz on 12/04/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var image = UIImage()
        image = UIImage(systemName: "magnifyingglass")!
        button.tintColor = .black
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    lazy var grauLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont(name: "Arial", size: 40)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "city"
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    lazy var backgroundImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "BackgroundDay")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var weatherImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max.fill")
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemYellow
        image.layer.shadowOpacity = 6
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setComponents()
        setConstraints()
    }
    
    func setComponents() {
        view.addSubview(backgroundImage)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(weatherImage)
        view.addSubview(grauLabel)
        view.addSubview(cityLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 12),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
            
            cityLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            grauLabel.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -20),
            grauLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            grauLabel.heightAnchor.constraint(equalToConstant: 30),
            
            weatherImage.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            weatherImage.bottomAnchor.constraint(equalTo: grauLabel.topAnchor, constant: -20),
            weatherImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            weatherImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 100)
        ])
    }
}
