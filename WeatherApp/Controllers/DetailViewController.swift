//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject{
    func didAddItem(with model: City)
}

class DetailViewController: UIViewController {
    
    public weak var delegate: DetailViewControllerDelegate?
    
    private let resultsView: ResultsView
    private let noResultsView: NoResultsView
    
    private var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(resultsView, noResultsView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        addConstraints()
    }
    
   
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.resultsView = ResultsView(frame: .zero)
        self.noResultsView = NoResultsView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func didTapAdd(){
        LocalDatabase.shared.setData(with: city?.name ?? "")
        NotificationCenter.default.post(name: NSNotification.Name("add"), object: nil)
        dismiss(animated: true)
    }
    
    @objc
    private func didTapCancel(){
        dismiss(animated: true)
    }
    
    private func addConstraints(){
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // No Results View
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            // Results View
            resultsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultsView.topAnchor.constraint(equalTo: view.topAnchor),
            resultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func configure(with model: City){
        DispatchQueue.main.async { [weak self] in
            self?.resultsView.configureView(with:
                            ResultsViewViewModel(
                                cityName: model.name,
                                weatherName: model.weather[0].main,
                                temperature: model.main.temp,
                                highTemp: model.main.temp_max,
                                lowTemp: model.main.temp_min))
            self?.city = model
            self?.resultsView.isHidden = false
        }
    }
    
    
    public func configureNoResult(model: String){
        DispatchQueue.main.async { [weak self] in
            self?.noResultsView.configure(model: model)
            self?.noResultsView.isHidden = false
        }
    }
}
