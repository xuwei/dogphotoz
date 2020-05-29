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
    var photos: [PhotoTableCellViewModel] = []
    
    /**
     performs API request to retrieve photos
     */
    func fetchPhotos(_ limit: Int)->Promise<Void> {
        return Promise<Void>() { resolver in
            DogAPI.shared.photoList(limit).done { [weak self] result in
                guard let self = self else { return }
                self.photos = []
                for photo in result {
                    let vm = PhotoTableCellViewModel(by: photo)
                    self.photos.append(vm)
                }
                resolver.fulfill(())
            }.catch { err in
                LoggingUtil.shared.cPrint(err)
                resolver.reject(err)
            }
        }
    }
    
    /**
     if we sort by descending order, maxSpan is used, if sort by ascending order, minSpan is used
     */
    func lifeSpanSortIn(_ order: SortOrder, completionHandler: ()->Void) {
        switch order {
        case .ascending:
            photos = photos.sorted { (vm1: PhotoTableCellViewModel, vm2: PhotoTableCellViewModel) -> Bool in
                return vm1.minSpan < vm2.minSpan
            }
        case .descending:
            photos = photos.sorted { (vm1: PhotoTableCellViewModel, vm2: PhotoTableCellViewModel) -> Bool in
                return vm1.maxSpan > vm2.maxSpan
            }
        }
    
        completionHandler()
    }
    
    func photoList()->[PhotoTableCellViewModel] {
        return photos
    }
}
