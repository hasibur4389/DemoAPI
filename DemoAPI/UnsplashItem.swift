//
//  UnsplashItem.swift
//  DemoAPI
//
//  Created by Hasibur Rahman on 27/4/23.
//

import UIKit

struct UnsplashItem: Codable {
    var id: String
    var description: String
    var alt_description: String
   
    var urls: [String: String]
    
}
