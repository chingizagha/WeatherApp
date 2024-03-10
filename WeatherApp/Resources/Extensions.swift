//
//  Extensions.swift
//  WeatherApp
//
//  Created by Chingiz on 07.03.24.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
