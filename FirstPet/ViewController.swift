//
//  ViewController.swift
//  FirstPet
//
//  Created by Улугбек Хайтметов on 01.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var weather: UILabel!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    @objc func buttonAction(){
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ data, response , error in
            if let data, let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data){
                DispatchQueue.main.async {
                    self.weather.text = "\(weatherData.currentWeather.temperature) °"
                }
            } else {
                print("Fail!")
            }
        }
        task.resume()
    }
}

