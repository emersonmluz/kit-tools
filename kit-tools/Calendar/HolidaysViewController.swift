import UIKit

class HolidaysViewController: UIViewController {
    var holidays: [NationalHolidays] = []
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
            holidaysTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setTouchScreen() {
        let touch = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
    
    func requestApi() {
        ApiManager.shared.apiRequest(url: "https://brasilapi.com.br/api/feriados/v1/", endpoint: yearTextField.text ?? "2020", modelType: [NationalHolidays].self) { escape in
            self.holidays = escape
            self.holidaysTableView.reloadData()
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
