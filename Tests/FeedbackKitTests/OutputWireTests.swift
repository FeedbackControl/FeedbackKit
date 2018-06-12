//
//  OutputWireTests.swift
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

final class OutputWireTests: XCTestCase {

    func testFabricateOutput() {
        let outputWire = OutputWire<TestWireLabel, TestOutputLabel>(label: .wire1)

        // Fabricate
        _ = outputWire.fabricateOutput(label: .output1, initialValue: AbsoluteSignal<String>.opened)

        // Assert
        if let retrievedOutput: Output<AbsoluteSignal<String>> = outputWire.output(withLabel: .output1) {
            XCTAssertNotNil(retrievedOutput)
        } else {
            XCTFail("Cannot retrieve output1")
        }
    }

    func testGetSubwire() {
        let outputWire = OutputWire<TestWireLabel, TestOutputLabel>(label: .wire1)

        // Fabricate
        _ = outputWire.fabricateOutput(label: .output1, initialValue: AbsoluteSignal<String>.opened)
        _ = outputWire.fabricateOutput(label: .output2, initialValue: AbsoluteSignal<String>.opened)

        // Subwire
        let subwire = outputWire.subwire(withOutputLabels: [.output2])

        // Assert
        let output1: Output<AbsoluteSignal<String>>? = subwire.output(withLabel: .output1)
        let output2: Output<AbsoluteSignal<String>>? = subwire.output(withLabel: .output2)
        XCTAssertNil(output1)
        XCTAssertNotNil(output2)
    }

    func testReleaseSubwire() {
        let outputWire = OutputWire<TestWireLabel, TestOutputLabel>(label: .wire1)

        // Fabricate
        _ = outputWire.fabricateOutput(label: .output1, initialValue: AbsoluteSignal<String>.opened)
        _ = outputWire.fabricateOutput(label: .output2, initialValue: AbsoluteSignal<String>.opened)

        // Subwire
        var subwire: OutputWire<TestWireLabel, TestOutputLabel>? = outputWire.subwire(withOutputLabels: [.output2])

        // Assert
        XCTAssertNotNil(subwire)

        // Release
        subwire = nil

        // Assert
        XCTAssertTrue(outputWire.subwires.allObjects.isEmpty)
    }

    static let allTests = [
        ("testFabricateOutput", testFabricateOutput),
        ("testGetSubwire", testGetSubwire),
        ("testReleaseSubwire", testReleaseSubwire)
    ]
}
