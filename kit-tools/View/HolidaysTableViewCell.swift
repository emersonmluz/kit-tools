import UIKit

class HolidaysTableViewCell: UITableViewCell {
    static var identifier = "holidaysCell"
    
    lazy var dayLabel = setLabel(fontSize: 18, textColor: .black)
    lazy var dayWeekLabel = setLabel(fontSize: 12, textColor: .gray)
    lazy var holidayLabel = setLabel(fontSize: 20, textColor: .black)
    lazy var monthLabel = setLabel(fontSize: 12, textColor: .white)
    
    var miniCalendarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
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
            miniCalendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            miniCalendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            miniCalendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            miniCalendarView.widthAnchor.constraint(equalToConstant: 100),
            
            dayWeekLabel.topAnchor.constraint(equalTo: miniCalendarView.topAnchor),
            dayWeekLabel.leadingAnchor.constraint(equalTo: miniCalendarView.leadingAnchor),
            dayWeekLabel.trailingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor),
            dayWeekLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dayLabel.topAnchor.constraint(equalTo: dayWeekLabel.bottomAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: miniCalendarView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: miniCalendarView.bottomAnchor),
            
            holidayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            holidayLabel.leadingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor, constant: 10),
            holidayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dayWeekLabel.topAnchor.constraint(equalTo: holidayLabel.bottomAnchor, constant: 10),
            dayWeekLabel.leadingAnchor.constraint(equalTo: miniCalendarView.trailingAnchor, constant: 10)
        ])
        
    }
    
    func configComponents(date: Date, holidayName: String) {
        dayWeekLabel.backgroundColor = .systemRed
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
