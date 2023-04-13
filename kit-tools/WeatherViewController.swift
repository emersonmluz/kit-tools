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
        requestApi()
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
            
            weatherImage.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            weatherImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            weatherImage.heightAnchor.constraint(equalToConstant: 100),
            weatherImage.widthAnchor.constraint(equalToConstant: 100),
            
            grauLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 50),
            grauLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            grauLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cityLabel.topAnchor.constraint(equalTo: grauLabel.bottomAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func requestApi() {
        ApiManager.shared.apiRequest(url: "https://api.openweathermap.org/data/2.5/weather?appid=aeefba332b49db396d425480b21571b2&units=metric&q=", endpoint: "porto%20alegre,br", modelType: WeatherModel.self) { escape in
            print(escape)
        }
    }
}
