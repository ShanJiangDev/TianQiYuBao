//
//  ViewController.swift
//  TianQiYuBao
//
//  Created by shan jiang on 04/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet weak var currentTLabel: UILabel?

    @IBOutlet weak var currentHumidityLabel: UILabel?

    @IBOutlet weak var currentPrecipitationLabel: UILabel?

    private let forecastAPIKey = "4d259a2a7a94a10a5cbe516e69fad08d"

    
//------------------- Version 1: all major functions are here -------------------//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        // NSBundle class : can access any data/class in the xcode project
//        // NSBundle object : represent a location in the file system and resource it to be useable in the program
//        // 1. Provide a properity starting directory by using a URL or File Path
//        // 2. Look for the resource we need in the the right places
//        
//        
//        // This code can only execute when we can , 
//        //  1 load the plist(get the location),
//        //  2 if plist can be convert to a NSDictionary
//        //  3 if the dictionary actually contain the key "currently"
//        
//        // Used string interpulation for the URL
//        
//
//// Method 1: read data from Plist
//        
////        if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"),
////        let weatherDictionary = NSDictionary(contentsOfFile: plistPath),
////        let currentWeatherDictionary = weatherDictionary["currently"] as? [String : AnyObject]{
////            
////            let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
////            
////            
////            currentTLabel?.text = "\(currentWeather.temperature)˚"
////       
////            currentHumidityLabel?.text = "\(currentWeather.humidity)˚"
////            
////            currentPrecipitationLabel?.text = "\(currentWeather.precipProbability)˚"
////            
////        }
//
//        
//        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
////        
////        // Hard code the location
//        let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
////        
//        
//// Method 2: red data from weatherForcast API
//        
////        //  A sychronized method, which will process while blocking all other request.
////        // Data object to fetch weather data
////        // NSData automatically do a network call with URL we provided and store the data in Json format
////        //   dataobject
////        
////            let weatherData = NSData(contentsOfURL: forecastURL!)
////        
////            print(weatherData)
//        
//        
//// Method 3: Concurent Method(Ascincronized Request)
//// This method make sure the main thread always goes first.
//// Use NSURLSession to fetch data:
//        
//        // 1.Create a configuration object:  configure a NSURLSession configuration object, it defines rules to use for updating and downloading data use a session. When uploading or downloading data creating a configuration object is always the first step.
//        
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        
//        
//        // 2.Create a session object The session object let you configure a buntch of different things such as cashing policys..
//        
//        let session = NSURLSession(configuration: configuration)
//        
//        // Use the session object we can carry a task to carry out. The base class for this purpose is NSURLSession task, but there are two subclasses more suited for this purpose: NSURLSession data task(return the content of URL derikt to the app memory as a NSURLData object), and NSURLSession downloading task(retrived the content of URL and save it to a temp file on the desk)
//        
//        // A task i screating as a method on our session object
//        
//        // 3. Creat a NSURLSession data task with a request method, that takes a NSURL request object and preform a get request == fetch some data from web. The method also have a compleeation handler is called whe task is complet.
//        
//        
//        // NSURLRequest Object
//        // This url is an optional, so we can wrap it with IF-LET syntax to check if it exist and then assign it, or for now we just un-wrap it with a "!"
//
//        let request = NSURLRequest(URL: forecastURL!)
//        
//        // We initial a NSURLRequest with an URL to creat a HTTP request that default to a get-request, now we can use this request to get a data task
//        
//        // Closure/closure expression restudy
//        // Parameter inside dataTaskWithRequest: data == contain a NSData object with result with our getRequest just like when we use the NSData method directely. The second is a NSURLResponse object contains a bunch of etadata about how the URL request was carried out, So we can check to see if the request was okay, and then access the data. If we have any error, the NSError object will store it.
//
//        
//        // Task is added to the session, the task is added to the session, it may active when we called the resume. When its done, the task automaticlly stop
//
//
//        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
//                print(data)
//                //print("I am on a background thread")
//            })
//            //print("I am on main thread")
//            dataTask.resume()
        
        
//------------------- Version 2: Use function from seperate classes -------------------//
   
    
    let coordinat: (lat: Double, lon: Double) = (37.8267,-122.423)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinat.lat, lon: coordinat.lon){
            (let currently) in
            
            // "(let currentWeather)" is an optional instance, so it can be nil
            
            if let currentWeather = currently{
                
                // Manage threads by GCD(Grand Central Dispatch), parallels processing threads on background and communicatied each other with special functions.
                // Process 1 grom GCD: Define the task we want to execute concurentelly, and add them to a dispatch que. GCD will handle the creation and management behind the sean
                
                
                // Update UI
                // Any of the UI related code have to be on the main thread
                
                // We need to make sure, even some of the value might be nil, we still need to display some other existed values. So we can not use the chained optional binding syntax"&&". 
                
                //dispatch_get_main_queue(): speciffy the main queue, and put the code inside the closure.
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    // Execute closure
                    
                    // All the variable are optional, so we need to check the existence first, then set the label.
                    // Single optional binding check
                    print("inside main quesue")
                    if let temperature = currentWeather.temperature{
                        // When refer a stored property from inside a closure, you always have to use the keyword "self".
                        print("current temperature is : \(temperature)")
                        self.currentTLabel?.text = "\(temperature)˚"
                    }
                    
                    if let humidity = currentWeather.humidity{
                        // When refer a stored property from inside a closure, you always have to use the keyword "self".
                        print("current humidity is : \(humidity)")
                        self.currentHumidityLabel?.text = "\(humidity)˚"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                }
                
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}


//Size class: available space or display environemnt, can have one of two vailues: compact or regular
//Regular class: assosiate with expensive displace space 
//Compact class: assosiate with constrain space
//To caraterized a display environment, we need to specify two size classes: one vertically, one horizatally