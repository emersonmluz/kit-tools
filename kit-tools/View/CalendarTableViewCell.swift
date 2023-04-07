//
//  CalendarCollectionCell.swift
//  kit-tools
//
//  Created by Émerson M Luz on 04/04/23.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    static let identifier = "calendarCell"
    
    private lazy var monthLabel: UILabel = {
        let label = setLabel(text: "")
        label.backgroundColor = .systemRed
        label.textColor = .white
        label.layer.borderWidth = 0.7
        label.font = UIFont(name: "Arial-BoldMT", size: 20)
        return label
    }()
    
    private lazy var week: [UILabel] = {
        var label: [UILabel] = []
        label.append(setLabel(text: "Dom"))
        label.append(setLabel(text: "Seg"))
        label.append(setLabel(text: "Ter"))
        label.append(setLabel(text: "Qua"))
        label.append(setLabel(text: "Qui"))
        label.append(setLabel(text: "Sex"))
        label.append(setLabel(text: "Sab"))
        for label in label {
            if label.text == "Dom" || label.text == "Sab" {
                label.textColor = .systemRed
            }
            label.font = UIFont(name: "Arial-BoldMT", size: 18)
            label.backgroundColor = .systemGray6
        }
        return label
    }()
    
    var calendar: DateFormatter = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.string(from: date)
        return formatter
    }()
    
    private lazy var dayLabel: [UILabel] = {
        var arrayLabel: [UILabel] = []
        for day in 1...31 {
            if day < 10 {
                arrayLabel.append(setLabel(text: "0" + String(day)))
            } else if day <= 31 {
                arrayLabel.append(setLabel(text: String(day)))
            }
        }
        return arrayLabel
    }()
    
    private lazy var containerOfDaysStackView: [UIStackView] = {
        var arrayStack: [UIStackView] = []
        for _ in 0...5 {
            arrayStack.append(setStackView())
        }
        return arrayStack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0))
    }
    
    func setCell(monthNumber: Int) {
        contentView.layer.borderWidth = 1
        setMonth(monthNumber: monthNumber)
        setComponents()
        setConstraints()
    }
    
    private func setComponents() {
        contentView.addSubview(monthLabel)
        for container in 0...containerOfDaysStackView.count - 1 {
            contentView.addSubview(containerOfDaysStackView[container])
        }
        for day in 0...6 {
            containerOfDaysStackView[0].addArrangedSubview(week[day])
        }
        setDays(container: 1, dayStart: 0, dayFinal: 6)
        setDays(container: 2, dayStart: 7, dayFinal: 13)
        setDays(container: 3, dayStart: 14, dayFinal: 20)
        setDays(container: 4, dayStart: 21, dayFinal: 27)
        setDays(container: 5, dayStart: 28, dayFinal: 30)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 30),
            
            containerOfDaysStackView[0].topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            containerOfDaysStackView[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[0].heightAnchor.constraint(equalToConstant: 20),
            
            containerOfDaysStackView[1].topAnchor.constraint(equalTo: containerOfDaysStackView[0].bottomAnchor, constant: 10),
            containerOfDaysStackView[1].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[1].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[1].heightAnchor.constraint(equalToConstant: 20),
            
            containerOfDaysStackView[2].topAnchor.constraint(equalTo: containerOfDaysStackView[1].bottomAnchor, constant: 10),
            containerOfDaysStackView[2].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[2].heightAnchor.constraint(equalToConstant: 20),
            
            containerOfDaysStackView[3].topAnchor.constraint(equalTo: containerOfDaysStackView[2].bottomAnchor, constant: 10),
            containerOfDaysStackView[3].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[3].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[3].heightAnchor.constraint(equalToConstant: 20),
            
            containerOfDaysStackView[4].topAnchor.constraint(equalTo: containerOfDaysStackView[3].bottomAnchor, constant: 10),
            containerOfDaysStackView[4].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[4].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[4].heightAnchor.constraint(equalToConstant: 20),
            
            containerOfDaysStackView[5].topAnchor.constraint(equalTo: containerOfDaysStackView[4].bottomAnchor, constant: 10),
            containerOfDaysStackView[5].leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerOfDaysStackView[5].trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerOfDaysStackView[5].bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setMonth(monthNumber: Int) {
        switch monthNumber {
        case 0:
            monthLabel.text = "Janeiro"
        case 1:
            monthLabel.text = "Fevereiro"
        case 2:
            monthLabel.text = "Março"
        case 3:
            monthLabel.text = "Abril"
        case 4:
            monthLabel.text = "Maio"
        case 5:
            monthLabel.text = "Junho"
        case 6:
            monthLabel.text = "Julho"
        case 7:
            monthLabel.text = "Agosto"
        case 8:
            monthLabel.text = "Setembro"
        case 9:
            monthLabel.text = "Outubro"
        case 10:
            monthLabel.text = "Novembro"
        case 11:
            monthLabel.text = "Dezembro"
        default:
            monthLabel.text = "Indisponível"
        }
    }
    
    private func setLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }
    
    private func setStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 0
        stack.layer.cornerRadius = 10
        stack.alignment = .top
        return stack
    }
    
    private func setDays(container: Int, dayStart: Int, dayFinal: Int) {
        var cont = 1
        let date = calendar.string(from: Date())
        for day in dayStart...dayFinal {
            if date == dayLabel[day].text || date < dayLabel[day].text! {
                containerOfDaysStackView[container].addArrangedSubview(dayLabel[day])
            } else if date > dayLabel[day].text! {
                containerOfDaysStackView[container].addArrangedSubview(dayLabel[Int(date)! + cont - Int(date)!])
            }
        cont += 1
        }
    }
}
