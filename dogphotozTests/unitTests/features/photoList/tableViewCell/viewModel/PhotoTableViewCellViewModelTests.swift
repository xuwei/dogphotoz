//
//  PhotoTableViewCellViewModelTests.swift
//  dogphotozTests
//
//  Created by Xuwei Liang on 30/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
@testable import dogphotoz

class PhotoTableViewCellViewModelTests: XCTestCase {

    func testExtractLifespanWithRangeValue() {
        var photo = TestDataUtil.shared.randomPhoto()
        photo.breeds = [TestDataUtil.shared.testBreedInfo(minSpan: 10, maxSpan: 12)]
        let vm = PhotoTableCellViewModel(by: photo)
        XCTAssertNotNil(vm)
        XCTAssertTrue(vm.minSpan == 10)
        XCTAssertTrue(vm.maxSpan == 12)
    }
    
    func testExtractLifespanWithSingleValue() {
        var photo = TestDataUtil.shared.randomPhoto()
        photo.breeds = [TestDataUtil.shared.testBreedInfoWithSingleValueLifespan(lifeSpan: 9)]
        let vm = PhotoTableCellViewModel(by: photo)
        XCTAssertNotNil(vm)
        XCTAssertTrue(vm.minSpan == 9)
        XCTAssertTrue(vm.maxSpan == 9)
    }
    
    func testExtractLifespanWithNAValue() {
        var photo = TestDataUtil.shared.randomPhoto()
        photo.breeds = [TestDataUtil.shared.testBreedInfoWithSingleValueLifespan(lifeSpan: -1)]
        let vm = PhotoTableCellViewModel(by: photo)
        XCTAssertNotNil(vm)
        
        /// this is for keeping NA lifespan items at the bottom of list
        /// lifespan with **Int.max** will stay at the bottom in ascending sort, and vice versa
        XCTAssertTrue(vm.minSpan == Int.max)
        XCTAssertTrue(vm.maxSpan == Int.min)
    }

}
