//
//  TestDataUtil.swift
//  dogphotozTests
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
@testable import dogphotoz

/**
  TestDataUtil is use for generating test data to facilitate unit testing 
 */
class TestDataUtil {
    
    static let shared = TestDataUtil()
    
    private init() { }
    
    /// Array for generating random String
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"
    
    /// helper method to generate **PhotoListViewModel** for testing purpose
    func testPhotoListViewModel()->PhotoListViewModel {
        let testVm = PhotoListViewModel()
        for index in 1...10 {
            var photo = TestDataUtil.shared.randomPhoto()
            photo.breeds = [TestDataUtil.shared.testBreedInfo(minSpan: index, maxSpan: index)]
            let vm = PhotoTableCellViewModel(by: photo)
            testVm.photos.append(vm)
        }
        return testVm
    }
    
    /// helper method to generate **PhotoListViewModel** with some empty lifeSpan
    func testPhotoListViewModelWithNALifeSpan()->PhotoListViewModel {
        let testVm = PhotoListViewModel()
        for index in 1...10 {
            var photo = TestDataUtil.shared.randomPhoto()
            photo.breeds = [TestDataUtil.shared.testBreedInfo(minSpan: index, maxSpan: index)]
            let vm = PhotoTableCellViewModel(by: photo)
            testVm.photos.append(vm)
        }
        
        for _ in 1...10 {
            var photo = TestDataUtil.shared.randomPhoto()
            photo.breeds = [TestDataUtil.shared.testBreedInfo(minSpan: -1, maxSpan: -1)]
            let vm = PhotoTableCellViewModel(by: photo)
            testVm.photos.append(vm)
        }
        
        return testVm
    }
    
    
    
    /// helper method to generate random **DogPhoto**
    func randomPhoto()-> DogPhoto {
        let photo = DogPhoto(id: randomString(4), url: randomString(4), width: 100, height: 100, breeds: [])
        return photo
    }
    
    /// helper method to generate test BreedInfo object
    /// putting minSpan as -1 is a trigger to generate a BreedInfo without lifeSpan
    func testBreedInfo(minSpan: Int, maxSpan: Int)-> BreedInfo {
        let info = BreedInfo(weight: testMetric(), height: testMetric(), id: randomId(), name: randomString(4), bredFor: randomString(4), breedGroup: randomString(4), lifeSpan: minSpan != -1 ? "\(minSpan) - \(maxSpan) years" : AppData.shared.NA, temperment: randomString(4))
        return info
    }
    
    func testBreedInfoWithSingleValueLifespan(lifeSpan: Int)-> BreedInfo {
        let info = BreedInfo(weight: testMetric(), height: testMetric(), id: randomId(), name: randomString(4), bredFor: randomString(4), breedGroup: randomString(4), lifeSpan: lifeSpan != -1 ? "\(lifeSpan) years" : AppData.shared.NA, temperment: randomString(4))
        return info
    }
    
    func testMetric()->Metric {
        return Metric(imperial: testMetricValue(), metric: testMetricValue())
    }
    
    func randomId()-> Int {
        return Int.random(in: 1...1000)
    }
    
    func testMetricValue()->String {
        return String(Int.random(in: 10...20))
    }
    
    /// Helper method for generating randomString of a given length
    func randomString(_ length: Int)-> String {
       var result = ""
       for _ in 0..<length {
           result.append(letters.randomElement() ?? "0")
       }
       return result
    }
}
