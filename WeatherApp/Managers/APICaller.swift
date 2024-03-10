//
//  APICaller.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    static let apiKey = "10adf77881f4c9b0a302f77b58f1aaf4"
    
}

final class APICaller {
    
    static let shared = APICaller()
    private var citiesArray: [City] = []
    
    func getCityWeather(with city: String, completion: @escaping (Result<City, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)&appid=\(Constants.apiKey)&q=\(city)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return}
            
            do {
                let results = try JSONDecoder().decode(City.self, from: data)
                completion(.success(results))
                
            } catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getCitiesWeather(completion: @escaping (Result<[City], Error>) -> Void){
        let cities = LocalDatabase.shared.getData()
        for i in cities{
            guard let url = URL(string: "\(Constants.baseURL)&appid=\(Constants.apiKey)&q=\(i)") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return}
                
                do {
                    let results = try JSONDecoder().decode(City.self, from: data)
                    self.citiesArray.append(results)
                    
                } catch{
                    print(error)
                }
            }
            task.resume()
        }
        
        do {
            print(citiesArray)
            completion(.success(citiesArray))
            
        } catch {
            completion(.failure(error))
        }
        
    }
}
