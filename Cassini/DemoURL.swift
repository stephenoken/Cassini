//
//  DemoURL.swift
//  Cassini
//
//  Created by Stephen O'Kennedy on 01/08/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import Foundation

struct DemoURL {
    static let Trinity = "http://www.irishtimes.com/polopoly_fs/1.1750748.1396630689!/image/image.jpg"
    
    static let NASA = [
        "Saturn":"http://apod.nasa.gov/apod/image/1608/BehindSaturn_Cassini_960.jpg",
        "ChesapeakeBay":"http://www.nasa.gov/sites/default/files/thumbnails/image/iss048-e-28526.jpg",
        "SpiralGalaxy":"http://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/hubble_friday_05062016.jpg"
        
    ]
    
    static func NASAImageNamed(imageName:String?) -> NSURL?{
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string: urlString)
        }else{
            return nil
        }
    }
}