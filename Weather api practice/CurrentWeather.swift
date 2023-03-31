//
//  CurrentWeather.swift
//  Weather api practice
//
//  Created by Adlet Zhantassov on 31.03.2023.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherDataModel) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        guard let unwrapped = currentWeatherData.weather.first?.id else { return nil}
        conditionCode = unwrapped
    }
}
