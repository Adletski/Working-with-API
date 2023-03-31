//
//  CurrentWeatherDataModel.swift
//  Weather api practice
//
//  Created by Adlet Zhantassov on 31.03.2023.
//

import Foundation

struct CurrentWeatherDataModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

