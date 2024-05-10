//
//  WeatherManager.swift
//  Clima
//
//  Created by Dakshi Goel on 02/05/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    var delegate: WeatherManagerDelegate?
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5d9bb31dd040e2e79c5b0075f301e34f&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performSearch(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performSearch(with: urlString)
    }
    
    
    func performSearch(with urlString: String){
        
        //1. Create URL
        if let url = URL(string: urlString){
            
            //2. Create URL session
            let session = URLSession(configuration: .default)
            
            //3. Give session a task
            //            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start task
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: cityName, temp: temp, conditionId: id)
            
            let weatherCondition = weather.condditionName
            let temperature = weather.tempString
            
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
