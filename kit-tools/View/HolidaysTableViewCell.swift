import UIKit

class HolidaysTableViewCell: UITableViewCell {
    static var identifier = "holidaysCell"
    
    lazy var dayLabel = setLabel(fontSize: 20, textColor: .black)
    lazy var dayWeekLabel = setLabel(fontSize: 14, textColor: .systemGray)
    lazy var holidayLabel = setLabel(fontSize: 18, textColor: .black)
    lazy var monthLabel = setLabel(fontSize: 16, textColor: .white)
    
    var miniCalendarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.borderWidth = 0.3
        return view
    }()
    
    func setCell (date: Date, holidayName: String) {
        setComponents()
        setConstraints()
        configComponents(date: date, holidayName: holidayName)
    }
    
    func setComponents() {
        contentView.addSubview(miniCalendarView)
        miniCalendarView.addSubview(dayLabel)
        miniCalendarView.addSubview(monthLabel)
        contentView.addSubview(dayWeekLabel)
        contentView.addSubview(holidayLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            miniCalendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            miniCalendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            miniCalendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            miniCalendarView.widthAnchor.constraint(equalToConstant: 75),
            
            monthLabel.topAnchor.constraint(equalTo: miniCalendarView.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: miniCalendarView.leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dayLabel.centerYAnchor.constraint(equalTo: miniCalendarView.centerYAnchor, constant: 15),
            dayLabel.leadingAnchor.constraint(equalTo: miniCalendarView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: miniCalendarView.bottomAnchor, constant: -10),
            
            holidayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            holidayLabel.leadingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor, constant: 10),
            holidayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dayWeekLabel.topAnchor.constraint(equalTo: holidayLabel.bottomAnchor, constant: 10),
            dayWeekLabel.leadingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor, constant: 15)
        ])
        
    }
    
    func configComponents(date: Date, holidayName: String) {
        monthLabel.backgroundColor = .systemRed
        monthLabel.font = UIFont(name: "Arial-BoldMT", size: 16)
        holidayLabel.textAlignment = .left
        monthLabel.text = convertDate(format: "MMM", date: date)
        dayLabel.text = convertDate(format: "dd", date: date)
        dayWeekLabel.text = convertDate(format: "EEEE", date: date)
        holidayLabel.text = holidayName
    }
    
    func convertDate(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    
    func setLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: fontSize)
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
}
