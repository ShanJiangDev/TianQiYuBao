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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // NSBundle class : can access any data/class in the xcode project
        // NSBundle object : represent a location in the file system and resource it to be useable in the program
        // 1. Provide a properity starting directory by using a URL or File Path
        // 2. Look for the resource we need in the the right places
        
        
        // This code can only execute when we can , 
        //  1 load the plist(get the location),
        //  2 if plist can be convert to a NSDictionary
        //  3 if the dictionary actually contain the key "currently"
        if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"),
        let weatherDictionary = NSDictionary(contentsOfFile: plistPath),
        let currentWeatherDictionary = weatherDictionary["currently"] as? [String : AnyObject]{
            
            let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
            
            
            currentTLabel?.text = "\(currentWeather.temperature)˚"
       
            currentHumidityLabel?.text = "\(currentWeather.humidity)˚"
            
            currentPrecipitationLabel?.text = "\(currentWeather.precipProbability)˚"
            
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