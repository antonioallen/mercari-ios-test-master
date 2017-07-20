//
//  ProductManager.swift
//  Mercari
//
//  Created by Antonio Allen on 7/13/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductManager {
    
    //Product Url Path
    let URL_PATH = ""
    
    static func getProducts(completion:@escaping(_ products: [Product], _ errorMessage:String?) -> Void){
        
        //Fetch Products From Network
        
        
        //Fetch Products Locally
        let path =  Bundle.main.path(forResource: "all", ofType: "json")
        if let jsonPath = path{
            
            do {
                let jsonString = try String(contentsOfFile: jsonPath, encoding: String.Encoding.utf8)
                completion(parseProducts(jsonDataString: jsonString), nil)
            } catch {
                print("Error Loading Data Locally From Json")
                completion([], "Error Loading Data Locally From Json")
            }
            
        }
        
    }
    
    
    //Parse Products From Json String
    static func parseProducts(jsonDataString:String) -> [Product]{
        var products:[Product] = []
        
        if let dataFromString = jsonDataString.data(using: .utf8, allowLossyConversion: false) {
            
            //Get Json Object From String
            let json = JSON(data: dataFromString)
            let data = json["data"].arrayValue
            
            //Validate Json Has Data
            if !data.isEmpty{
                
                for object in data{
                    
                    //Convert To Dictionary and Add Product
                    if let dictionary = object.dictionaryObject as NSDictionary?{
                        if let product = Product.from(dictionary){
                            products.append(product)
                        }
                    }
                }
                
            }else{
                print("Data is Empty")
            }
            
        }else{
            print("Error Loading Data Locally From Json")
        }
        
        return products
    }
}
