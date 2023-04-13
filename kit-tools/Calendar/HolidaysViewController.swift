import UIKit

class HolidaysViewController: UIViewController {
    var holidays: [NationalHolidaysModel] = []
    var years: [Int] = {
        var array: [Int] = []
        for year in 1980...2100 {
            array.append(year)
        }
        return array
    }()
    
    lazy var holidaysTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HolidaysTableViewCell.self, forCellReuseIdentifier: HolidaysTableViewCell.identifier)
        return tableView
    }()
    
    lazy var yearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        textField.inputView = picker
        let date = Date()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        textField.text = formatter.string(for: date)
        textField.textAlignment = .center
        textField.backgroundColor = .systemBlue
        textField.font = UIFont(name: "Arial", size: 30)
        textField.textColor = .white
        textField.delegate = self
        return textField
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
        setContraints()
        setTouchScreen()
        requestApi()
    }
    
    func setComponents() {
        view.addSubview(yearTextField)
        view.addSubview(holidaysTableView)
        view.addSubview(loadingView)
        loadingView.addSubview(activity)
    }
    
    func setContraints() {
        NSLayoutConstraint.activate([
            yearTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            yearTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            yearTextField.heightAnchor.constraint(equalToConstant: 75),
            
            holidaysTableView.topAnchor.constraint(equalTo: yearTextField.bottomAnchor),
            holidaysTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            holidaysTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            holidaysTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activity.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    func setTouchScreen() {
        let touch = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
    
    func requestApi() {
        loadingView.isHidden = false
        activity.startAnimating()
        ApiManager.shared.apiRequest(url: "https://brasilapi.com.br/api/feriados/v1/", endpoint: yearTextField.text ?? "2020", modelType: [NationalHolidaysModel].self) { holidays, error in
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                guard let holidays = holidays else {
                    self.activity.stopAnimating()
                    self.loadingView.isHidden = true
                    self.yearTextField.text = "2023"
                    let alert = UIAlertController(title: "Erro", message: "Falha ao buscar dados!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendi", style: .default))
                    self.present(alert, animated: true)
                    return}
                
                self.holidays = holidays
                self.holidaysTableView.reloadData()
                self.activity.stopAnimating()
                self.loadingView.isHidden = true
            }
        }
    }
}

extension HolidaysViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HolidaysTableViewCell.identifier) as! HolidaysTableViewCell
        cell.setCell(date: holidays[indexPath.row].date, holidayName: holidays[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HolidaysViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(years[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextField.text = String(years[row])
    }
}

extension HolidaysViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        requestApi()
    }
}
