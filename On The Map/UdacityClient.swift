//
//  UdacityClient.swift
//  On The Map
//
//  Created by Candice Reese on 3/13/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    
    var session = URLSession.shared
    
    override init() {
        super.init()
        
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
            
        }
        return Singleton.sharedInstance
        
    }
    
    
    func logInToUdacity (email: String, password: String, completionHandler: @escaping ((_ success: Bool, _ result: AnyObject?, _ error: NSError?) -> Void)) {
        let urlString = Constants.UdacityAPI.BaseURL + Constants.UdacityAPI.ApiPath + "/" + Constants.UdacityParameters.SessionID
        //print(urlString)
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        //print(request)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"email\", \"password\": \"password\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            var errorString = ""
            
            guard (error == nil) else {
                completionHandler(false, response, error as NSError?)
                print("Eror in Error = nil")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? HTTPURLResponse {
                    errorString = "The error was: \(response.statusCode)"
                }
                
                print(errorString)
                
                completionHandler(false, response, error as NSError?)
                print("Error in StatusCode")
                return
            }
            
            guard let data = data else {
                completionHandler(false, response, error as NSError?)
                print("Error in data = data")
                return
            }
            
            let range = Range(5 ..< data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            //UdacityClient.sharedInstance().parJSONDataForLogin(data, completionHandler: completionHandler)
            
        }
        
        task.resume()
    }
    
}
