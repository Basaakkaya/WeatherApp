//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Başak Kaya on 9.07.2023.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController, ConstraintRelatableTarget {
    ///computed property
    private lazy var cityNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 35)
        view.textColor = .black
        view.textAlignment = .center
        return view
        
    }()
    
    private lazy var tempTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .black
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 25)
        view.textColor = .cyan
        view.backgroundColor = .yellow
        return view
        
    }()
    
    private lazy var weatherConditionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .lightGray
        view.backgroundColor = .orange
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
        view.backgroundColor = .white
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
        view.addSubview(tempTitleLabel)
        view.addSubview(tempLabel)
        view.addSubview(weatherConditionLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(0)
        }
        
        tempTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(0)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(tempTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(0)
        }
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(0)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
//        updateConstraints()
    }
    
    func updateConstraints() {
        self.cityNameLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(50)
        }
    }
    
    func feed(response: WeatherResponseModel) {
        tempTitleLabel.text = "Temp"
        cityNameLabel.text = response.name
        if let temp = response.main?.temp {
            tempLabel.text = "\(temp)"
        }
        if let feelsLike = response.main?.feelsLike {
            weatherConditionLabel.text = "\(feelsLike)"
        }
    }
}
