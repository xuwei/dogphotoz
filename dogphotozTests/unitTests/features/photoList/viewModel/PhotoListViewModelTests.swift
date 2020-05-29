//
//  PhotoListViewModelTests.swift
//  dogphotozTests
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
import Foundation
@testable import dogphotoz

class PhotoListViewModelTests: XCTestCase {
    
    
    
    func testLifeSpanSortInAscending() {
        let expectation = XCTestExpectation(description: "testLifeSpanSortInAscending")
        let testVm = TestDataUtil.shared.testPhotoListViewModel()
        LoggingUtil.shared.cPrint(testVm)
        XCTAssertNotNil(testVm)
        XCTAssertTrue(testVm.photos.count == 10)
        testVm.lifeSpanSortIn(.ascending) {
            var max: Int = 0
            for vm in testVm.photoList() {
                guard vm.minSpan >= max else { XCTFail(); expectation.fulfill(); return }
                max = vm.minSpan
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testLifeSpanSortInDescending() {
        let expectation = XCTestExpectation(description: "testLifeSpanSortInDescending")
        let testVm = TestDataUtil.shared.testPhotoListViewModel()
        LoggingUtil.shared.cPrint(testVm)
        XCTAssertNotNil(testVm)
        XCTAssertTrue(testVm.photos.count == 10)
        testVm.lifeSpanSortIn(.descending) {
            var min: Int = Int.max
            for vm in testVm.photoList() {
                guard vm.maxSpan <= min else { XCTFail(); expectation.fulfill(); return }
                min = vm.maxSpan
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testLifeSpanWithNoLifeSpanInDataDesc() {
        let expectation = XCTestExpectation(description: "testLifeSpanWithNoLifeSpanInData")
        let testVm = TestDataUtil.shared.testPhotoListViewModelWithNALifeSpan()
        LoggingUtil.shared.cPrint(testVm)
        XCTAssertNotNil(testVm)
        XCTAssertTrue(testVm.photos.count == 20)
        testVm.lifeSpanSortIn(.descending) {
            var min: Int = Int.max
            for vm in testVm.photoList() {
                guard vm.maxSpan <= min else { XCTFail(); expectation.fulfill(); return }
                min = vm.maxSpan
            }
            
            /// to make sure that invalid data is at the bottom, we will check the last 10 items
            for index in 10...19 {
                let photoList = testVm.photoList()
                let vm = photoList[index]
                XCTAssertTrue(vm.lifeSpan == AppData.shared.NA)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    
    func testLifeSpanWithNoLifeSpanInDataAsc() {
        let expectation = XCTestExpectation(description: "testLifeSpanWithNoLifeSpanInData")
        let testVm = TestDataUtil.shared.testPhotoListViewModelWithNALifeSpan()
        LoggingUtil.shared.cPrint(testVm)
        XCTAssertNotNil(testVm)
        XCTAssertTrue(testVm.photos.count == 20)
        testVm.lifeSpanSortIn(.ascending) {
            var max: Int = 0
            for vm in testVm.photoList() {
                guard vm.minSpan >= max else { XCTFail(); expectation.fulfill(); return }
                max = vm.minSpan
            }
            
            /// to make sure that invalid data is at the bottom, we will check the last 10 items
            for index in 10...19 {
                let photoList = testVm.photoList()
                let vm = photoList[index]
                XCTAssertTrue(vm.lifeSpan == AppData.shared.NA)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testPhotoList() {
        let testVm = TestDataUtil.shared.testPhotoListViewModel()
        XCTAssertNotNil(testVm)
        XCTAssertTrue(testVm.photoList().count == 10)
        testVm.photos = []
        XCTAssertTrue(testVm.photoList().count == 0)
    }
}
