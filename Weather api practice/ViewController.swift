//
//  ViewController.swift
//  Weather api practice
//
//  Created by Adlet Zhantassov on 31.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    var networkWeatherManager = NetworkWeatherManager()
    
    //MARK: - UI Elements
    
    private lazy var weatherIconImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Astana"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25 C"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like 20 C"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        networkWeatherManager.delegate = self
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }
    
    @objc func searchButtonPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city) 
        }
    }
    
    
}

extension ViewController: NetworkWeatherManagerDelegate {
    
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        print(currentWeather.cityName)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(searchButton)
        let views = [weatherIconImageView,temperatureLabel,feelsLikeTemperatureLabel,stackView]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        weatherIconImageView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIconImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        feelsLikeTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    private func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        ac.addTextField { tf in
            let cities = ["San Francisko","Stambul","Moscow","Viena","New York"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
//                print("search info for the \(cityName)")
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
}
