//
//  NoResultsView.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import UIKit

class NoResultsView: UIView {
    
    private let viewModel = NoResultsViewViewModel()
    
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(iconImageView, titleLabel)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 90),
            iconImageView.heightAnchor.constraint(equalToConstant: 90),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10)
        ])
    }
    
    public func configure(model: String) {
        iconImageView.image = viewModel.image
        titleLabel.text = model
    }

    


}
