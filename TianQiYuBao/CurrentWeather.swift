//
//  CurrentWeather.swift
//  TianQiYuBao
//
//  Created by shan jiang on 04/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//

import Foundation

struct CurrentWeather{
    let temperature: Int
    let humidity: Int
    let precipProbability: Int
    let summary: String
    
    // ! implies “this might trap,” while ? indicates “this might be nil.”
    // AnyObject can represent an instance of any class type.
    // Any can represent an instance of any type at all, including function types.
    
    init(weatherDictionary: [String: AnyObject]){
        temperature = weatherDictionary["temperature"] as! Int
        //in the plist, the number is float, so to get the full data from plist, we change the value to double first, then change it to integer by multiply by 100
        let humidityFloat = weatherDictionary["humidity"] as! Double
        humidity = Int(humidityFloat*100)
        
        let precipProbabilityFloat = weatherDictionary["precipProbability"] as! Double
        precipProbability = Int(precipProbabilityFloat*100)
        
        summary = weatherDictionary["summary"] as! String
        
    }
    
}