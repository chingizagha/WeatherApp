//
//  ResultsView.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import UIKit

class ResultsView: UIView {
    
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 14, weight: .light)
//        label.text = "14:34"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private let weatherNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 45, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        addSubviews(cityNameLabel, temperatureLabel, weatherNameLabel, highTempLabel, lowTempLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherNameLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            weatherNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            highTempLabel.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor, constant: 10),
            highTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            
            lowTempLabel.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor, constant: 10),
            lowTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 20),
        ])
    }
    
    
    
    public func configureView(with viewModel: ResultsViewViewModel){
        cityNameLabel.text = viewModel.cityName
        temperatureLabel.text = "\(Int(viewModel.temperature))°"
        weatherNameLabel.text = viewModel.weatherName
        highTempLabel.text = "\(Int(viewModel.highTemp))°"
        lowTempLabel.text = "\(Int(viewModel.lowTemp))°"
    }


}
