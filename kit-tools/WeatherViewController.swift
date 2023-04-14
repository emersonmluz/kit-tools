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
        textField.placeholder = "Digite uma cidade"
        textField.textAlignment = .center
        textField.delegate = self
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var image = UIImage()
        image = UIImage(systemName: "magnifyingglass")!
        button.tintColor = .black
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(searchButtonClick(_:)), for: .touchUpInside)
        return button
    }()
    
    var grauLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 40)
        label.backgroundColor = .systemGreen
        label.clipsToBounds = true
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    var maxTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.backgroundColor = .systemBlue
        label.clipsToBounds = true
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    var minTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.backgroundColor = .systemRed
        label.clipsToBounds = true
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.backgroundColor = .systemBrown
        label.clipsToBounds = true
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    var windSpeed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.backgroundColor = .systemPurple
        label.clipsToBounds = true
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    var backgroundImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "BackgroundDay")
        image.contentMode = .scaleToFill
        return image
    }()
    
    var weatherImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.tintColor = .systemYellow
        image.layer.shadowOpacity = 6
        return image
    }()
    
    var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.6
        view.isHidden = false
        return view
    }()
    
    var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .white
        activity.style = .large
        return activity
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setComponents()
        setConstraints()
        setTouchScreen()
        apiRequest(city: "porto%20alegre")
    }
    
    func setComponents() {
        view.addSubview(backgroundImage)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(weatherImage)
        view.addSubview(grauLabel)
        view.addSubview(cityLabel)
        view.addSubview(maxTemperature)
        view.addSubview(minTemperature)
        view.addSubview(windSpeed)
        view.addSubview(humidity)
        view.addSubview(loadingView)
        loadingView.addSubview(activity)
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
            
            weatherImage.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            weatherImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            weatherImage.heightAnchor.constraint(equalToConstant: 85),
            weatherImage.widthAnchor.constraint(equalToConstant: 85),
            
            grauLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 50),
            grauLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            grauLabel.heightAnchor.constraint(equalToConstant: 45),
            
            cityLabel.topAnchor.constraint(equalTo: grauLabel.bottomAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            minTemperature.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 22),
            minTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            minTemperature.heightAnchor.constraint(equalToConstant: 28),
            
            maxTemperature.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 22),
            maxTemperature.trailingAnchor.constraint(equalTo: minTemperature.leadingAnchor, constant: -15),
            maxTemperature.heightAnchor.constraint(equalToConstant: 28),
            
            windSpeed.topAnchor.constraint(equalTo: maxTemperature.bottomAnchor, constant: 15),
            windSpeed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            windSpeed.heightAnchor.constraint(equalToConstant: 28),
            
            humidity.topAnchor.constraint(equalTo: windSpeed.bottomAnchor, constant: 15),
            humidity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            humidity.heightAnchor.constraint(equalToConstant: 28),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activity.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    @objc func searchButtonClick(_: UIGestureRecognizer) {
        searchCity()
        searchTextField.text = ""
    }
    
    func setTouchScreen() {
        let touch = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
    
    func searchCity() {
        guard searchTextField.text != nil && searchTextField.text != "" else {return}
        let city = searchTextField.text?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        apiRequest(city: city ?? "")
    }
    
    func apiRequest(city: String) {
        loadingView.isHidden = false
        activity.startAnimating()
        let url = "https://api.openweathermap.org/data/2.5/weather?appid=aeefba332b49db396d425480b21571b2&units=metric&q="
        ApiManager.shared.apiRequest(url: url, endpoint: city, modelType: WeatherModel.self) { weather, error in
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                guard let weather = weather else {
                    self.loadingView.isHidden = true
                    self.activity.stopAnimating()
                    let alert = UIAlertController(title: "Erro", message: "Falha ao buscar dados!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendi", style: .default))
                    self.present(alert, animated: true)
                    return}
                
                switch weather.weather.first?.state {
                case "Sun", "Clear":
                    self.weatherImage.image = UIImage(systemName: "sun.max.fill")
                    self.weatherImage.tintColor = .systemYellow
                case "Clouds", "Mist":
                    self.weatherImage.image = UIImage(systemName: "cloud.fill")
                    self.weatherImage.tintColor = .systemGray4
                case "Rain":
                    self.weatherImage.image = UIImage(systemName: "cloud.rain.fill")
                    self.weatherImage.tintColor = .systemGray4
                case "Drizzle":
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle.fill")
                    self.weatherImage.tintColor = .systemGray4
                case "Snow":
                    self.weatherImage.image = UIImage(systemName: "snow")
                    self.weatherImage.tintColor = .white
                default:
                    self.weatherImage.image = nil
                    let alert = UIAlertController(title: nil, message: "Imagem do clima não mapeada para essa região.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendi", style: .cancel))
                    self.present(alert, animated: true)
                }
                
                self.grauLabel.text = " " + String(Int(weather.temperature.temp)) + " °C" + " "
                self.cityLabel.text = weather.city + " - " + weather.locale.country
                self.maxTemperature.text = " " + String(Int(weather.temperature.tempMax)) + " °C" + " "
                self.minTemperature.text = " " + String(Int(weather.temperature.tempMin)) + " °C" + " "
                self.windSpeed.text = " Vento: " + String(Int(weather.wind.speed)) + " Km/h" + " "
                self.humidity.text = " UR " + String(Int(weather.temperature.humidity)) + "%" + " "
                self.loadingView.isHidden = true
                self.activity.stopAnimating()
            }
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchCity()
        searchTextField.text = ""
    }
}
