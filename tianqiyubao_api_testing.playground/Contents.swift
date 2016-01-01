//: Playground - noun: a place where people can play

import UIKit
import Foundation

let forecastAPIKey = "4d259a2a7a94a10a5cbe516e69fad08d"

let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")



let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)

forecastURL