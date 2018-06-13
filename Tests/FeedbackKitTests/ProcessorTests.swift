//
//  ProcessorTests.swift
//  FeedbackKitTests
//
//  Copyright (c) 2018 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import FeedbackKit

final class ProcessorTests: XCTestCase {

    func testRegisterAndGetWire() {
        let wire1 = Wire<TestWireLabel>(label: .wire1)
        let wire2 = Wire<TestWireLabel>(label: .wire2)
        let processor = Processor<TestWireLabel>()

        // Register wires.
        processor.register(wire1)
        processor.register(wire2)

        // Assert
        XCTAssertNotNil(processor.wire(withLabel: .wire1))
        XCTAssertNotNil(processor.wire(withLabel: .wire2))
        XCTAssertEqual(ObjectIdentifier(processor.wire(withLabel: .wire1)!), ObjectIdentifier(wire1))
        XCTAssertEqual(ObjectIdentifier(processor.wire(withLabel: .wire2)!), ObjectIdentifier(wire2))
    }

    static let allTests = [
        ("testRegisterAndGetWire", testRegisterAndGetWire)
    ]
}
