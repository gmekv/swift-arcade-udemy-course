//
//  CurrencyFormatterTests.swift
//  BankeyTests
//
//  Created by Giorgi Mekvabishvili on 25.01.26.
//

import Testing
import XCTest

@testable import Bankey

struct CurrencyFormatterTests {

    class Test: XCTestCase {
        var formatter: CurrencyFormatter!
        
        override func setUp() {
            super.setUp()
            formatter = CurrencyFormatter()
        }
        
        func testBreakDollarsIntoCents() throws {
            let result = formatter.breakIntoDollarsAndCents(929466.23)
            XCTAssertEqual(result.0, "929,466")
            XCTAssertEqual(result.1, "23")
        }
        func testDollarsFormatted() throws {
            let result = formatter.dollarsFormatted(929466.23)
            XCTAssertEqual(result, "$929,466.23")
        }
        
        func testZeroDollarsFormatted() throws {
            let result = formatter.dollarsFormatted(0.00)
            XCTAssertEqual(result, "$0.00")
        }
    }
}
