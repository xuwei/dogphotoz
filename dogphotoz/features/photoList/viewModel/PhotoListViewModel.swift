//
//  PhotoListViewModel.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation
import PromiseKit

class PhotoListViewModel {
    
    let screenName = ScreenName.photoList.rawValue
    
    private var photos: [PhotoTableCellViewModel] = []
    
    func fetchPhotos(_ limit: Int)->Promise<Void> {
        return Promise<Void>() { resolver in
            DogAPI.shared.photoList(limit).done { [weak self] photos in
                guard let self = self else { return }
                
                self.photos = photos.map { (photo) -> PhotoTableCellViewModel in
                    let vm = PhotoTableCellViewModel()
                    vm.update(by: photo)
                    return vm
                }
                
                resolver.fulfill(())
            }.catch { err in
                LoggingUtil.shared.cPrint(err)
                resolver.reject(err)
            }
        }
    }
    
    func photoList()->[PhotoTableCellViewModel] {
        return photos
    }
}
