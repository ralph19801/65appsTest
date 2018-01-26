//
//  _5apps_4Tests.swift
//  65apps-4Tests
//
//  Created by Garafutdinov Ravil on 18/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import XCTest
@testable import _5apps_4

class _5apps_4Tests: XCTestCase {
    
    let validator = RGLoginValidator()
    
    func testMinLengthFailure() {
        XCTAssert(validator.isValidLogin("a1") == false)
    }
    
    func testMinLengthSuccess() {
        XCTAssert(validator.isValidLogin("a12") == true)
    }
    
    func testMaxLengthDigitsFailure() {
        XCTAssert(validator.isValidLogin("a12345678901234567890123456789012") == false)
    }
    
    func testMaxLengthLettersFailure() {
        XCTAssert(validator.isValidLogin("qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM") == false)
    }
    
    func testMaxLengthDotsFailure() {
        XCTAssert(validator.isValidLogin("a................................") == false)
    }
    
    func testMaxLengthMinusFailure() {
        XCTAssert(validator.isValidLogin("a--------------------------------") == false)
    }
    
    func testMaxLengthVariousFailure() {
        XCTAssert(validator.isValidLogin("a-.abcABC-.abcABC-.abcABC-.abcABC-.abcABC") == false)
    }

    func testMaxLengthDigitsSuccess() {
        XCTAssert(validator.isValidLogin("a1234567890123456789012345678901") == true)
    }

    func testMaxLengthLettersSuccess() {
        XCTAssert(validator.isValidLogin("qwertyuiopasdfghjklzxcvbnm") == true)
    }
    
    func testMaxLengthCapsSuccess() {
        XCTAssert(validator.isValidLogin("QWERTYUIOPASDFGHJKLZXCVBNM") == true)
    }
    
    func testMaxLengthDotsSuccess() {
        XCTAssert(validator.isValidLogin("a...............................") == true)
    }

    func testMaxLengthMinusSuccess() {
        XCTAssert(validator.isValidLogin("a-------------------------------") == true)
    }

    func testFirstLetterSuccess() {
        XCTAssert(validator.isValidLogin("a123") == true)
    }
    
    func testFirstCapsSuccess() {
        XCTAssert(validator.isValidLogin("A123") == true)
    }
    
    func testFirstDigitFailure() {
        XCTAssert(validator.isValidLogin("123") == false)
    }

    func testFirstDotFailure() {
        XCTAssert(validator.isValidLogin(".123") == false)
    }
    
    func testFirstMinusFailure() {
        XCTAssert(validator.isValidLogin("-123") == false)
    }
    
    func testFirstOtherFailure() {
        XCTAssert(validator.isValidLogin("^abcABC") == false)
    }
    
    func testVariousOtherFailure() {
        XCTAssert(validator.isValidLogin("a[]123") == false)
    }

    func testVariousSuccess() {
        XCTAssert(validator.isValidLogin("abcABC-.abcABC-.abcABC-.") == true)
    }
    
    func testZeroLengthFailure() {
        XCTAssert(validator.isValidLogin("") == false)
    }
}
