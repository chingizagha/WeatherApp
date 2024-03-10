//
//  CityMainViewControllerCell.swift
//  WeatherApp
//
//  Created by Chingiz on 07.03.24.
//

import UIKit

final class CityMainViewControllerCell: UICollectionViewCell {
    
    static let identifier = "CityMainViewControllerCell"

    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Baku"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "14:34"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Windy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 45, weight: .light)
        label.text = "9°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "H:10°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "L:5°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(cityNameLabel, timeLabel,
                               weatherNameLabel, temperatureLabel,
                                highTempLabel, lowTempLabel
        )
        setUpLayer()
        addConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 20
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            timeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            weatherNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            weatherNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            temperatureLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            lowTempLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            lowTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            highTempLabel.rightAnchor.constraint(equalTo: lowTempLabel.leftAnchor),
            highTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    
    public func configure(with model: City){
        cityNameLabel.text = model.name
        timeLabel.text = setDateWithTimezone(with: model.timezone)
        weatherNameLabel.text = "\(model.weather[0].main)"
        temperatureLabel.text = "\(Int(model.main.temp))°"
        highTempLabel.text = "H:\(Int(model.main.temp_max))° "
        lowTempLabel.text = "L:\(Int(model.main.temp_min))°"
        
    }
    
    private func setDateWithTimezone(with timezoneData: Int) -> String{
        let timezone = TimeZone(secondsFromGMT: timezoneData)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let timezone = timezone {
            dateFormatter.timeZone = timezone
            
            let currentTime = Date()
            let formattedTime = dateFormatter.string(from: currentTime)
            
            return formattedTime
        } else {
            return "Invalid timezone"
        }
    }
    
}
