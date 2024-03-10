//
//  LocalDatabase.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import Foundation

final class LocalDatabase {
    static let shared = LocalDatabase()
        

    
    func setData(with city: String){
        var defaults = UserDefaults.standard.stringArray(forKey: "cities01") ?? [String]()
        defaults.append(city)
        UserDefaults.standard.set(defaults, forKey: "cities01")
    }
    
    func getData() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "cities01") ?? [String]()
    }
    
    
}
