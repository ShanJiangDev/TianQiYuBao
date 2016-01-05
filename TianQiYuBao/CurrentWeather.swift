//
//  CurrentWeather.swift
//  TianQiYuBao
//
//  Created by shan jiang on 04/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//

import Foundation
import UIKit

// Because of the forecastweater API may or may not give us these informations, so here we set them all into optional


//Enum: Create an object that represents a set of finite points values
// Use it when we want to encapsulate a finite set of date
// Here we use an enum to define an icon type that captures all these possible values.

enum Icon: String{
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage?{
        var imageName: String

        switch self{
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "cloudy-night.png"
        }
        return UIImage(named:imageName)
        
    }
    
}


struct CurrentWeather{
    var temperature: Float?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    
    // Because weatherIcon can be updated, so we use the failable init method named, and pass in a string named default.png to create this default image
    
    // Failable init returns an optional UI image instance, which is why we are specifying an optional property over here.
    
    
    var icon: UIImage? = UIImage(named:"default.png")
    
    // ! implies “this might trap,” while ? indicates “this might be nil.”
    // AnyObject can represent an instance of any class type.
    // Any can represent an instance of any type at all, including function types.
    
    // !: we are dorce downcasting, using the exclamation point with the as operator to a certain type in the init method. So there's never any chance for it to be nil. So we change all the "!" to "?", because we might get nil to the variable
    
    
    //in the plist, the number is float, so to get the full data from plist, we change the value to double first, then change it to integer by multiply by 100
    
    // Since we are using the variable immeditaly, so we wrap it with a if statement while using "?" at the same time.
    
    

    init(weatherDictionary: [String: AnyObject]){
        
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
        
        if let rawTemperature = weatherDictionary["temperature"] as? Float{
            temperature = fahrenheitToCelsium(rawTemperature)
        }else{
            temperature = nil
        }
        
        // Icon:
        // Make sure we saving the right icon:
        //  Check to see if there is a existed value of key word "icon" in our weather dictionary        
        //      If it doesnt, return default image
        //      if it does, call helper method and sign the correct icon image.
        
        // Logic:
        // Create a UIImage instance
        // Use the named initializer to create an image
        // Passing in the "imageName" string
        
        // Step by Step
        // Match the value from "iconString" and "icon"
        // 1. Enum can be initialized by passing the rawValue
        // 2. If the value matches one of the associated values in icon enum
        // 3. then we can get the relevant enum member back, that enum value will be assigned to the constant "iconValue" we just created
        
        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon:Icon = Icon(rawValue: iconString){
            icon = weatherIcon.toImage()
        }
        
    }
    // Helper function for sign the correct icon image

    func fahrenheitToCelsium(fehrenheitTemperature: Float) -> Float?{
        return ((fehrenheitTemperature - 32)/1.8)
    }
    
    
}






