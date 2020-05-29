//
//  AppData.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//
import UIKit
import Hex

class AppData {
    
    /// Singleton instance
    static let shared = AppData()
    
    /// N/A string
    let NA = "N/A"
    
    /// image place holder
    let placeholder = UIImage.init(named: ImageNames.placeholder.rawValue)
    
    /// random colors array, used for side borders of photos in SearchViewController
    let colors: [UIColor] = [ UIColor.init(hex: "FF4500"), UIColor.init(hex: "7FFFD4"), UIColor.init(hex: "191970"), UIColor.init(hex: "FAED267"), UIColor.init(hex: "FF8300")]
}
