import UIKit

class HolidaysViewController: UIViewController {
    var holidays: [NationalHolidays] = []
    
    lazy var holidaysTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HolidaysTableViewCell.self, forCellReuseIdentifier: HolidaysTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setComponents()
        setContraints()
        requestApi()
    }
    
    func setComponents() {
        view.addSubview(holidaysTableView)
    }
    
    func setContraints() {
        NSLayoutConstraint.activate([
            holidaysTableView.topAnchor.constraint(equalTo: view.topAnchor),
            holidaysTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            holidaysTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            holidaysTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func requestApi() {
        ApiManager.shared.apiRequest(url: "https://brasilapi.com.br/api/feriados/v1/", endpoint: "2023", modelType: [NationalHolidays].self) { escape in
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
