//
//  Photo.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

struct DogPhoto: Codable {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int
    let breeds: [BreedInfo]
}

    
