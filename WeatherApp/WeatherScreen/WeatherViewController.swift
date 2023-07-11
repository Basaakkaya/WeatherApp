//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Başak Kaya on 9.07.2023.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    ///computed property
    private lazy var cityNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 35)
        view.textColor = .black
        return view
        
    }()
    
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 25)
        view.textColor = .cyan
        return view
        
    }()

    private lazy var weatherConditionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .lightGray
        return view
        
    }()
    
    private let viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        setUpViews()
        view.backgroundColor = .blue
    }
    
    private func getWeatherData() {
        viewModel.getWeatherData(of: "Izmir") { response in
            DispatchQueue.main.async {
                self.feed(response: response)
            }
        } onError: { error in
            print(error)
        }
    }
    
    private func setUpViews() {
        view.addSubview(cityNameLabel)
        view.addSubview(tempLabel)
        view.addSubview(weatherConditionLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func feed(response: WeatherResponseModel) {
        cityNameLabel.text = response.name
        if let temp = response.main?.temp {
            tempLabel.text = "\(temp)"
        }
//        weatherConditionLabel.text = response.desc
        
    }
}
