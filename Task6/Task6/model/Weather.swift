//
//  Weather.swift
//  Task6
//
//  Created by sophia on 9/5/19.
//  Copyright © 2019 sophia. All rights reserved.
//

import Foundation
struct Weather{
    let summary:String
    let icon:String
    let temperature:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    init(json:[String:Any]) throws {
        
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        guard let temperature = json["temperatureLow"] as? Double else{throw SerializationError.missing("temperature is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
    }
    static let basePath = "https://api.darksky.net/forecast/45122c31abf7de6052b81f52fddc8558/"
    
    static func forecase (withLocation location:String, completion: @escaping ([Weather])->()){
      
        let url = basePath + location
        let request = URLRequest(url: URL(string:url)!)

        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
         
            var forecastArray:[Weather] = []
            
            if let data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                      
                        if let dailyForcasts = json["daily"] as? [String: Any]{

                            guard let array = dailyForcasts["data"] as? [[String:Any]] else {return}
                            
                            for object in array
                            {
                                
                                if let weartherObject = try? Weather(json: object){
                                    forecastArray.append(weartherObject)
                                }

                                
                            }
                      }
                            
                          
                        
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    
                }
                completion(forecastArray)
            }
           
        }
        
            task.resume()
        }
        
    }


