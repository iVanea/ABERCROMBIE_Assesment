//
//  Content.swift
//  AandF_CodeTest
//
//  Created by Timotin Ion on 3/21/19.
//  Copyright © 2019 Timotin. All rights reserved.
//

import Foundation

public struct Content {
//    let elementType : String?
    let title : String?
    let target : String?
   
    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }
    
    init(content: [String:Any]) throws{
//        if let elementType = content["elementType"] as? String {
//            self.elementType = elementType
//        }else {
//            self.elementType = nil
////            throw  SerializationError.missing("Element type is missing")
//        }
        
        if let title = content["title"] as? String {
            self.title = title
        }
        else {
            self.title = nil
        }
        
        if let target = content["target"] as? String {
            self.target = target
        }
        else {
            self.target = nil
        }
        
    }
    
}
