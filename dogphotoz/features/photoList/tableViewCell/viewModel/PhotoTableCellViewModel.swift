//
//  PhotoListTableViewModel.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/**
 ViewModel for **PhotoTableViewCell**, minSpan and maxSpan is used for sorting
 When sorting by ascending order, minSpan is used to have minimum life span in ascending order
 When sorting by descending order, maxSpan is used to have maximum life span in descending order
 */
class PhotoTableCellViewModel {

    var minSpan: Int = 0
    var maxSpan: Int = Int.max
    var lifeSpan: String = ""
    var display: String = ""
    var imageUrl: URL? = nil
    
    init(by photo: DogPhoto) {
        
        // there are cases there breeds array is empty from retrieve data
        if !photo.breeds.isEmpty {
            let info = photo.breeds[0]
            display = info.name ?? ""
            lifeSpan = info.lifeSpan ?? AppData.shared.NA
        } else {
            display = photo.id ?? ""
            lifeSpan = AppData.shared.NA
        }
        
        imageUrl =  URL(string: photo.url ?? "")
        extractLifeSpan(lifeSpan)
    }
    
    /**
     Helper method to extract minSpan and maxSpan
     */
    func extractLifeSpan(_ lifeSpan: String) {
        /// if lifeSpan is NA, then set minSpan very high, and maxSpan very low, so we make sure
        /// these data don't show at the top in either sorting order
        if lifeSpan == AppData.shared.NA { minSpan = Int.max; maxSpan = Int.min; return }
        
        let components = lifeSpan.replacingOccurrences(of: "years", with: "").components(separatedBy: "-")
        guard components.count > 0 else { return }
        minSpan =  extractInt(components.first ?? "") ?? 0
        maxSpan = minSpan
        guard components.count > 1 else { return }
        maxSpan = extractInt(components.last ?? "") ?? Int.max
    }
    
    private func extractInt(_ text: String)->Int? {
        return Int(text.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

extension PhotoTableCellViewModel: CellViewModelProtocol {
    
    static func identifier() -> String {
        return Identifier.photoTableViewCell.rawValue
    }
}
