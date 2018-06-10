//
//  OutputPinTests.swift
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

final class OutputPinTests: XCTestCase {

    func testInitialValue() {
        let outputPin = OutputPin<AbsoluteSignal<String>>(value: .opened, bag: Bag())

        // Assert
        XCTAssertEqual(outputPin.value, .opened)
    }

    func testBroadcastValue() {
        var broadcastedValue = AbsoluteSignal<String>.opened

        let bag = Bag<AbsoluteSignal<String>>()
        _ = bag.insert { value in broadcastedValue = value }
        let outputPin = OutputPin<AbsoluteSignal<String>>.init(value: .opened, bag: bag)

        // Broadcast value
        outputPin.broadcast(.closed)

        // Assert
        XCTAssertEqual(broadcastedValue, .closed)
        XCTAssertEqual(outputPin.value, .closed)
    }

    func testFabricateOutputPinAndOutput() {
        var broadcastedValue = AbsoluteSignal<String>.opened

        let (outputPin, output) = OutputPin<AbsoluteSignal<String>>
            .fabricate(initialValue: AbsoluteSignal<String>.opened)
        output.observe { value in broadcastedValue = value }

        // Broadcast value
        outputPin.broadcast(.closed)

        // Assert
        XCTAssertEqual(output.value, .closed)
        XCTAssertEqual(broadcastedValue, .closed)
    }

    func testDisposeOutputObserver() {
        var broadcastedValue = AbsoluteSignal<String>.opened

        let (outputPin, output) = OutputPin<AbsoluteSignal<String>>
            .fabricate(initialValue: AbsoluteSignal<String>.opened)
        let disposable = output.observe { value in broadcastedValue = value }

        // Dispose
        disposable.dispose()
        // Broadcast value
        outputPin.broadcast(.closed)

        // Assert
        XCTAssertEqual(output.value, .closed)
        XCTAssertEqual(broadcastedValue, .opened)
    }

    static let allTests = [
        ("testInitialValue", testInitialValue),
        ("testBroadcastValue", testBroadcastValue),
        ("testFabricateOutputPinAndOutput", testFabricateOutputPinAndOutput),
        ("testDisposeOutputObserver", testDisposeOutputObserver)
    ]
}
