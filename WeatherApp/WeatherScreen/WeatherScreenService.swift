//
//  WeatherScreenService.swift
//  WeatherApp
//
//  Created by Başak Kaya on 9.07.2023.
//

import Foundation
import UIKit

class WeatherScreenService {
    func fetchWeatherData(cityName: String,
                          onSuccess: @escaping(WeatherResponseModel) -> Void,
                          onError: @escaping(String) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=410ac5770587616c9b3e1daab40b8707"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                onError("an error occured")
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                onSuccess(responseModel)
            } catch {
                onError(error.localizedDescription)
            }
        }
        task.resume()
    }
}
