//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chingiz on 07.03.24.
//

// Detail Section
// Add Button
// Footer text
// Optional Add Spinner

import UIKit
import SwipeCellKit

class MainViewController: UIViewController {
    
    // TODO: Add Spinner
    let dataSource = [ "Edit List", "Fahrenheit", "Celcius"]

    private var isCelcius: Bool = true
    
    private var citiesArray: [City] = [] {
        didSet{
            citiesCollectionView.reloadData()
        }
    }
    private let detailVC = DetailViewController()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "Learn more about weather data and map data")
        
        attributedString.addAttribute(.link, value: "terms://termsofCondition", range: (attributedString.string as NSString).range(of: "weather data"))
        attributedString.addAttribute(.link, value: "privacy://privacypolicy", range: (attributedString.string as NSString).range(of: "map data"))
        
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.linkTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        textView.attributedText = attributedString
        textView.textColor = .systemGray
        textView.isSelectable = true
        textView.isEditable = false
        //textView.delaysContentTouches = false
        textView.isScrollEnabled = false
        return textView
    }()

    
    
    let citiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = {indexPath in
            let del = UIContextualAction(style: .destructive, title: "delete") { action, view, completion in
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [del])
        }
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CityMainViewControllerCell.self, forCellWithReuseIdentifier: CityMainViewControllerCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        var menuChildren: [UIMenuElement] = []
        
        menuChildren.append(UIAction(title: "Edit List", handler: { _ in
            
        }))
        
        menuChildren.append(UIAction(title: "Celcius", handler: { _ in
            if !self.isCelcius{
                for i in 0..<self.citiesArray.count {
                    self.citiesArray[i].main.temp = self.fahrenheitToCelsius(self.citiesArray[i].main.temp)
                    self.citiesArray[i].main.temp_max = self.fahrenheitToCelsius(self.citiesArray[i].main.temp_max)
                    self.citiesArray[i].main.temp_min = self.fahrenheitToCelsius(self.citiesArray[i].main.temp_min)
                }
                DispatchQueue.main.async { [weak self] in
                    self?.citiesCollectionView.reloadData()
                    self?.isCelcius = true
                }
            }
        }))
        
        menuChildren.append(UIAction(title: "Fahrenheit", handler: { _ in
            if self.isCelcius{
                for i in 0..<self.citiesArray.count {
                    self.citiesArray[i].main.temp = self.celsiusToFahrenheit(self.citiesArray[i].main.temp)
                    self.citiesArray[i].main.temp_max = self.celsiusToFahrenheit(self.citiesArray[i].main.temp_max)
                    self.citiesArray[i].main.temp_min = self.celsiusToFahrenheit(self.citiesArray[i].main.temp_min)
                }
                DispatchQueue.main.async { [weak self] in
                    self?.citiesCollectionView.reloadData()
                    self?.isCelcius = false
                }
            }
        }))
        
        
        
        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        
        button.showsMenuAsPrimaryAction = true
        //button.changesSelectionAsPrimaryAction = true
        
        //button.frame = CGRect(x: 150, y: 200, width: 100, height: 40)
        
        let customBarButtonItem = UIBarButtonItem(customView: button)
        
        
        navigationItem.rightBarButtonItem = customBarButtonItem
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        view.addSubviews(searchBar, citiesCollectionView, termsTextView)
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        searchBar.delegate = self
        detailVC.delegate = self
        termsTextView.delegate = self
        addConstraints()
        let cities = LocalDatabase.shared.getData()
        for i in cities {
            APICaller.shared.getCityWeather(with: i) { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let model):
                        self?.citiesArray.append(model)
                    case .failure(_):
                        print("")
                    }
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("add"), object: nil, queue: nil) { _ in
            self.addNewItem()
        }
    }
    
    private func celsiusToFahrenheit(_ c: Double) -> Double {
       return (c * 9/5) + 32
    }
    
    private func fahrenheitToCelsius(_ f: Double) -> Double {
       return (f - 32) * 5/9
    }
    
    private func fa(c: Double) -> Double {
       return (c * 9/5) + 32
    }

    private func addNewItem(){
        let cities = LocalDatabase.shared.getData()
        APICaller.shared.getCityWeather(with: cities[cities.endIndex - 1]) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let model):
                    self?.citiesArray.append(model)
                case .failure(_):
                    print("")
                }
            }
        }
    }

    private func addConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            citiesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            citiesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            citiesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            citiesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            termsTextView.topAnchor.constraint(equalTo: citiesCollectionView.bottomAnchor),
            termsTextView.centerXAnchor.constraint(equalTo: citiesCollectionView.centerXAnchor),
            //termsTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityMainViewControllerCell.identifier, for: indexPath) as? CityMainViewControllerCell else {fatalError()}
        let cityModel = citiesArray[indexPath.row]
        cell.configure(with: cityModel)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.configure(with: citiesArray[indexPath.row])
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width: CGFloat
        width = (bounds.width-30)
        return CGSize(width: width, height: width/2.8)
    }
    // TODO: Add Removing cell option
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2 else {return}
        
        APICaller.shared.getCityWeather(with: query) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let model):
                    let vc = DetailViewController()
                    vc.configure(with: model)
                    let cities = LocalDatabase.shared.getData()
                    if cities.contains(model.name) {
                        self?.present(vc, animated: true)
                    }
                    let nav = UINavigationController(rootViewController: vc)
                    self?.present(nav, animated: true)
                case .failure(_):
                    let vc = DetailViewController()
                    vc.configureNoResult(model: "\(query)")
                    self?.present(vc, animated: true)
                }
            }
        }
        searchBar.text = ""
    }
}

extension MainViewController: DetailViewControllerDelegate{
    func didAddItem(with model: City) {
        
    }
}



extension MainViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}
