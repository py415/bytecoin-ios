//
//  Constant.swift
//  ByteCoin
//
//  Created by Philip Yu on 5/19/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Constant {
    
    // MARK: - Properties
    static let apiKey = fetchFromPlist(forResource: "ApiKeys", forKey: "API_KEY")
    
    // MARK: - Functions
    static func fetchFromPlist(forResource resource: String, forKey key: String) -> String? {
        
        let filePath = Bundle.main.path(forResource: resource, ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value = plist?.object(forKey: key) as? String
        
        return value
        
    }
    
}
