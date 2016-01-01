//
//  NetworkOperation.swift
//  TianQiYuBao
//
//  Created by shan jiang on 31/12/15.
//  Copyright © 2015 Shan Jiang. All rights reserved.
//

import Foundation

class NetworkOperation{
    // This class's major job is downloading json file from api
    
    // Lazy Loading:Delay initialization of object until the point at which it is needed.
    // Only work with "var" variable
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    
    // Call back function with closures : Add notification when file is downloaded
    
    // Type Alias Keywords: it allows us to give an alternate name for a type in your program. Rather than having to rewrite the type signature everywhere, you can refer to it using the type alias.
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url:NSURL){
        self.queryURL = url
    }
    

    // The completion parameter from this Closures has a lengthy type, by using Alias Keyowrds, we don't need to type the dictionary parameter all the times.
    //func downloadJSONFromURL(completion:([String:AnyObject]? ->())
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        
        let request : NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            
// The upper two lines equal to:
// let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            // 1. Check HTTP response for successful GET request
            
            // An HTTP response is a message that the server sends to the client when it receives an HTTP request. The response contains information about the data, size of the request and other things like the status code.
            
            // The response object in this data task method is return as an NSURL response object. To get the status codes, we first need to cast it to an NSHTTPURLResponse object using optional binding.
            
            // The reason i cast it is because an NSURLResponse object does not have a status code property. But an NSHTTPURLResponse does, and so by casting it, we can check the status code
            if let httpResponse = response as? NSHTTPURLResponse{
                
                // To get the code we use the status code property on the HTTPResponse object. Since we could get a bunch of different status codes back depending on whether the request failed or succeeded, this is a grate place to use a switch statement. We can switch on the status code\
                
                switch(httpResponse.statusCode){
                    
                    // https://httpstatuses.com/ All the possiable tatus code from HTTP
                
                case 200:
                    
                    // 2. Create JSON object with data.
                    // Once we have a json dictionary back,  we are going to return it in our completion handler.(not parsing JSON file here)
                    
                    // Use a built-in class and a method to converting the data object to a JSON object:
                    
                    // as? [String:Anyobject : cast the variable to a dictionary
                    
//                    let jsonDictionary =  try!                                                               NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:Anyobject]
                        let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: [])) as? [String: AnyObject]
                        completion(jsonDictionary)
                 
                default:
                    print("Get request not successful, HTTP status code: \(httpResponse.statusCode)")
    
                }
            // If the casting is not successful    
            }else{
                print("Error: Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
    }
    
}


















