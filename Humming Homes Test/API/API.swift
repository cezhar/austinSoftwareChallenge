//
//  API.swift
//  Humming Homes Test
//
//  Created by Cezhar Arévalo on 13-01-22.
//

import Foundation


class API: NSObject{
    
    class func getPeople(completion: @escaping(_ people:[String]?) -> Void){
       
        
        guard let url = URL(string: "https://swapi.dev/api/people/") else{
            return
        }
        let task = URLSession.shared.dataTask(with:url){data,response,error in
            
            guard response != nil else{
                completion(nil)
                return
            }
            var results = NSDictionary()
            
            do{
                if let data = data{
                    results = (try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])) as! NSDictionary
                }
            }catch{
                completion(nil)
            }
            guard let result = results["results"] as? [NSDictionary] else{
                completion(nil)
                return
            }
            
            
            var people = [String]()
            
            for res in result{
                if let p = res["name"] as? String{
                    people.append(p)
                }
            }
            
            completion(people)
            
            
        }
        task.resume()
    }
    
}
