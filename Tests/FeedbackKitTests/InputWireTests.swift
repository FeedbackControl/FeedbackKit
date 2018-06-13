//
//  InputWireTests.swift
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

final class InputWireTests: XCTestCase {

    func testFabricateInput() {
        let inputWire = InputWire<TestWireLabel, TestInputLabel>(label: .wire1)

        // Fabricate
        inputWire.fabricateInput(label: .input1) { (value: String) in }

        // Assert
        if let retrievedInput: Input<String> = inputWire.input(withLabel: .input1) {
            XCTAssertNotNil(retrievedInput)
        } else {
            XCTFail("Cannot retrieve output1")
        }
    }

    func testGetSubwire() {
        let inputWire = InputWire<TestWireLabel, TestInputLabel>(label: .wire1)

        // Fabricate
        inputWire.fabricateInput(label: .input1) { (value: String) in }
        inputWire.fabricateInput(label: .input2) { (value: String) in }

        // Subwire
        let subwire = inputWire.subwire(withInputLabels: [.input2])

        // Assert
        let input1: Input<String>? = subwire.input(withLabel: .input1)
        let input2: Input<String>? = subwire.input(withLabel: .input2)
        XCTAssertNil(input1)
        XCTAssertNotNil(input2)
    }

    func testReleaseSubwire() {
        let inputWire = InputWire<TestWireLabel, TestInputLabel>(label: .wire1)

        // Fabricate
        inputWire.fabricateInput(label: .input1) { (value: String) in }
        inputWire.fabricateInput(label: .input2) { (value: String) in }

        // Subwire
        var subwire: InputWire<TestWireLabel, TestInputLabel>? = inputWire.subwire(withInputLabels: [.input2])

        // Assert
        XCTAssertNotNil(subwire)

        // Release
        subwire = nil

        // Assert
        XCTAssertTrue(inputWire.subwires.isEmpty)
    }

    static let allTests = [
        ("testFabricateInput", testFabricateInput),
        ("testGetSubwire", testGetSubwire),
        ("testReleaseSubwire", testReleaseSubwire)
    ]
}
