//
//  ViewController.swift
//  WeatherApp
//
//  Created by Başak Kaya on 9.07.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiService = WeatherScreenService()
        let viewModel = WeatherViewModel(apiService: apiService)
        let weatherVC = WeatherViewController(viewModel: viewModel)
        navigationController?.pushViewController(WeatherViewController(viewModel: viewModel), animated: true)
        view.backgroundColor = .purple
    }
    //410ac5770587616c9b3e1daab40b8707

}

