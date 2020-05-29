//
//  UIEnums.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

/**
    Enum for screen names
 */
enum ScreenName: String {
    case photoList = "Photo List"
}

/**
    TableViewCell identifiers
 */
enum Identifier: String {
    case photoTableViewCell = "PhotoTableViewCell"
}

/**
    Image names
*/
enum ImageNames: String {
    case placeholder = "placeholder"
}


/**
    Sort order
 */
enum SortOrder: String {
    case ascending = "asc"
    case descending = "desc"
    
    func reverse()->SortOrder {
        return (self == .ascending) ? .descending : .ascending
    }
}

/**
   Popup titles
 */
enum PopupTitle: String {
    case error = "Error"
}
