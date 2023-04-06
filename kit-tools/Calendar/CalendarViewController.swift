//
//  CalendarViewController.swift
//  kit-tools
//
//  Created by Émerson M Luz on 04/04/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    lazy var calendarTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        return tableView
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
        view.addSubview(calendarTableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            calendarTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.monthSymbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarTableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier) as! CalendarTableViewCell
        cell.setCell(monthNumber: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}
