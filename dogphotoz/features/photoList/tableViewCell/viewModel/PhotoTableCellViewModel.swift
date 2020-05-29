//
//  PhotoListTableViewModel.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

class PhotoTableCellViewModel {

    var lifeSpan: String = ""
    var display: String = ""
    var imageUrl: URL? = nil
    
    func update(by photo: DogPhoto) {
        guard !photo.breeds.isEmpty else { return }
        let info = photo.breeds[0]
        display = info.name ?? ""
        lifeSpan = info.lifeSpan ?? ""
        imageUrl =  URL(string: photo.url ?? "")
    }
}

extension PhotoTableCellViewModel: CellViewModelProtocol {
    
    func identifier() -> String {
        return Identifier.photoTableViewCell.rawValue
    }
}
