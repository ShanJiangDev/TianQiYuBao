//
//  ForcastService.swift
//  TianQiYuBao
//
//  Created by shan jiang on 31/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//


// Closure: Call back function, get notify when the task is complete, because its happening in the background.

import Foundation

struct ForecastService{
    
    let forecastAPIKey: String
    let forecastBaseURL : NSURL?
    
    init(APIKey:String){
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    // Use closure here because: Inside this method, we are going to call the download JSON method of our network operation, which makes an asynchronous call. You can't return an object from inside the closure, so we cant just return the data that we need unless we implement a callback through a closure. We also returning current weather as an optional, because our network request could fail, and we need to return nil in such case.
    // CurrentWeather? ==== optional
    func getForecast(lat: Double, lon: Double, completion:(CurrentWeather? -> Void)){
     
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL:forecastBaseURL){
            
            let networkOperation = NetworkOperation(url: forecastURL)
            
            networkOperation.downloadJSONFromURL{
                (let JSONDictionary) in
                // Here we want to parse the contents of the dictionary, and then create apopulated instance of current weather
                
                // Return instance of currentWeather through closure below
                
                let currentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary)
                
                // When we call "completion" it call the completion handler from the function
                // This line pass the currentWeather to the completion handler so that when we call getForecast, we have access to it.
                // It bubbles up into the completion handler "completion:(CurrentWeather? -> Void)" , So in the view control, if we call the getForecast method, when we complete the completion handler and access the current weather variable over here "completion:(CurrentWeather? -> Void)", we are getting access to this "completion(currentWeather)" populated instance that we are passing up
                completion(currentWeather)
                
                // With this currentWeather instance, we can assign it to the completion handler so that when we call get forecast, we have access to it.
            }
        
        }else{
            
            print("Could not construct a valid URL")
            
        }
        
    }
    
    // Method: gets an instance of currentWeather from a JSON dictionary
    
    // Using optional binding to make sure our JSON dictionary returns a non-nil value for the key currently over here "jsonDictionary?["currently"]" If it does that, we're casting it to a dictionary type, over "as? [String: Anyobject]"
    func currentWeatherFromJSONDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentWeather?{
        
        // And then we assign our JSON dictionary to the constant current weather dictionary
        
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String:AnyObject]{
        
        // Add main parsing code here
        // Assign the curretn weather dictionary as an argument for the init method of our current weather struct, and return the resulting in instance.
        
            // The initializer "CurrentWeather" takes a dictionary.
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        }else{
        
            // Where json file dont have the "currently" key
            print("JSON dictionary returned nil for 'currently' key")
            // We can return nil here, because CurentWeather is optional "?"
            return nil
        
        }
    }
    
}





















