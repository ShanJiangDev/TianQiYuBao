//
//  CurrentWeather.swift
//  TianQiYuBao
//
//  Created by shan jiang on 04/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//

import Foundation

// Because of the forecastweater API may or may not give us these informations, so here we set them all into optional

struct CurrentWeather{
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    
    // ! implies “this might trap,” while ? indicates “this might be nil.”
    // AnyObject can represent an instance of any class type.
    // Any can represent an instance of any type at all, including function types.
    
    // !: we are dorce downcasting, using the exclamation point with the as operator to a certain type in the init method. So there's never any chance for it to be nil. So we change all the "!" to "?", because we might get nil to the variable
    
    
    //in the plist, the number is float, so to get the full data from plist, we change the value to double first, then change it to integer by multiply by 100
    
    // Since we are using the variable immeditaly, so we wrap it with a if statement while using "?" at the same time.
    
    
    init(weatherDictionary: [String: AnyObject]){
        
        temperature = weatherDictionary["temperature"] as? Int
        

        
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        
        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double{
            precipProbability = Int(precipProbabilityFloat*100)
        }else{
            precipProbability = nil
            
        }
        
        summary = weatherDictionary["summary"] as? String
        
    }
    
}