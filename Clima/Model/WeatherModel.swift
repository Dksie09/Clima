//
//  WeatherModel.swift
//  Clima
//
//  Created by Dakshi Goel on 04/05/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let cityName: String
    let temp: Double
    let conditionId: Int
    
    var tempString: String{
        return String(format: "%.1f", temp)
    }
    
    var bgName: String {switch conditionId {
    case 200...232:
        return "background-thunderstorm"
    case 300...321:
        return "background-rainy"
    case 500...531:
        return "background-rainy"
    case 600...622:
        return "background-snow"
    case 701...781:
        return "background-haze"
    case 800:
        return "background-clear"
    case 801...804:
        return "background-cloudy"
    default:
        return "background-cloudy"
    }}
    
    var condditionName : String {switch conditionId {
    case 200...232:
        return "cloud.bolt"
    case 300...321:
        return "cloud.drizzle"
    case 500...531:
        return "cloud.rain"
    case 600...622:
        return "cloud.snow"
    case 701...781:
        return "cloud.fog"
    case 800:
        return "sun.max"
    case 801...804:
        return "cloud.bolt"
    default:
        return "cloud"
    }}
    
}
