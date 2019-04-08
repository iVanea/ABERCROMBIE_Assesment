//
//  Product.swift
//  AandF_CodeTest
//
//  Created by Timotin Ion on 3/21/19.
//  Copyright © 2019 Timotin. All rights reserved.
//
// https://www.hackingwithswift.com/example-code/libraries/how-to-parse-json-using-swiftyjson
import Foundation

public struct Product {
    let title : String?
    let backgroundImage : String?
    let content : [Content]
    let promoMessage : String?
    let topDescription : String?
    let bottomDescription : String?
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json: [String:Any]) throws{
        guard let title = json["title"] as? String else { throw  SerializationError.missing("Title is missing")}
        
        if let bottomDescription =  json["bottomDescription"] as? String {
            self.bottomDescription = bottomDescription
        } else {
            self.bottomDescription = nil
        }
        
        if let topDescription =  json["topDescription"] as? String {
            self.topDescription = topDescription
        } else {
            self.topDescription = nil
        }
        
        if let promoMessage =  json["promoMessage"] as? String {
            self.promoMessage = promoMessage
        }else {
            self.promoMessage = nil
        }
        
        if let backgroundImage =  json["backgroundImage"] as? String {
            self.backgroundImage = backgroundImage
        }else {
            self.backgroundImage = nil
        }
        
        var content : [Content] = []
        if let buttons =  json["content"] as? [[String:Any]] {
            
            for button in buttons {
                if let c = try? Content(content: button){
                    content.append(c)
                }
            }
            
        }
        else { throw SerializationError.missing("Content is missing!")
        }
        
        
        self.title = title
        self.content = content
    }
    
    static let basePathToAPI = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json"
    
    static func hotProducts (completion:@escaping([Product]) -> ()){
        let request = URLRequest(url:URL(string:basePathToAPI)!)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response:URLResponse?, error:Error?) in
            
            var productArray:[Product] = []
            if let data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        
                        for product in json {
                            
                                if let productObject = try? Product(json: product){
                                    productArray.append(productObject)
                                }
                            }
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
            completion(productArray)
        }
        
        task.resume()
        
    }
}
