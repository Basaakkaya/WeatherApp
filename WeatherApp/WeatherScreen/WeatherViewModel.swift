//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Başak Kaya on 9.07.2023.
//

import Foundation

class WeatherViewModel {
    
    private let apiService: WeatherScreenService
    
    init(apiService: WeatherScreenService = WeatherScreenService()) {
        self.apiService = apiService
    }
    
    func getWeatherData(of cityName: String, onsuccess:@escaping(WeatherResponseModel) -> Void,
        onError:@escaping(String) -> Void)
    
    {
        apiService.fetchWeatherData(cityName: cityName) { response in
            print(response)
            print(response.weather?.first)
            onsuccess(response)
        } onError: { error in
            print(error)
            onError(error)
        }
    }
}
