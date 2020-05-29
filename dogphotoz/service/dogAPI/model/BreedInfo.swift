//
//  BreedInfo.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

struct BreedInfo: Codable {
    let weight: Metric?
    let height: Metric?
    let id: Int?
    let name: String?
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperment: String?
    
    private enum CodingKeys: String, CodingKey {
        case weight
        case height
        case id
        case name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperment
    }
}
