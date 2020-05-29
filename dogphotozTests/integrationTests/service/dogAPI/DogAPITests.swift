//
//  DogAPITests.swift
//  dogphotozTests
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
import PromiseKit
@testable import dogphotoz

class DogAPITests: XCTestCase {

    func testPhotoListWithoutLimitParam() {
        let expectation = XCTestExpectation(description: "testPhotoListWithoutLimitParam")
        let limit = 0
        DogAPI.shared.photoList(limit).done { resp in
            XCTFail()
            expectation.fulfill()
            
        }.catch { err in
            guard let resultError = err as? DogAPIError else {  XCTFail(); return }
            XCTAssertTrue(resultError.localizedDescription == DogAPIError.invalidParams.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testPhotoListWithoutLimitParamTooBig() {
        let expectation = XCTestExpectation(description: "testPhotoListWithoutLimitParam")
        let limit = 1001
        DogAPI.shared.photoList(limit).done { resp in
            XCTFail()
            expectation.fulfill()
        }.catch { err in
            guard let resultError = err as? DogAPIError else {  XCTFail(); return }
            XCTAssertTrue(resultError.localizedDescription == DogAPIError.invalidParams.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testPhotoListWithoutLimitValidParam() {
        let expectation = XCTestExpectation(description: "testPhotoListWithoutLimitParam")
        let limit = 100
        DogAPI.shared.photoList(limit).done { resp in
            XCTAssertTrue(resp.count == limit)
            expectation.fulfill()
        }.catch { err in
            XCTFail()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
}
