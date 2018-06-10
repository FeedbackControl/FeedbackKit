//
//  BagTests.swift
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

final class BagTests: XCTestCase {

    func testInsertObserver() {
        let bag = Bag<AbsoluteSignal<String>>()
        let observer = { (signal: AbsoluteSignal<String>) in }

        // Insert
        let token = bag.insert(observer)

        // Assert
        XCTAssertEqual(bag.observers.count, 1)
        XCTAssertEqual(bag.observers.first?.token, token)
    }

    func testRemoveObserver() {
        let bag = Bag<AbsoluteSignal<String>>()
        let observer = { (signal: AbsoluteSignal<String>) in }

        // Insert
        let token = bag.insert(observer)
        // Remove
        bag.removeObserver(withToken: token)

        // Assert
        XCTAssertEqual(bag.observers.count, 0)
    }

    func testBroadcastSignal() {
        // Flag
        var broadcastedSignal = AbsoluteSignal<String>.opened

        let bag = Bag<AbsoluteSignal<String>>()
        let observer = { (signal: AbsoluteSignal<String>) in
            broadcastedSignal = signal
        }

        // Insert
        _ = bag.insert(observer)
        // Broadcast
        bag.broadcast(.closed)

        // Assert
        XCTAssertEqual(broadcastedSignal, .closed)
    }

    func testBroadcastSignalInSequence() {
        // Flag
        var observerIndex = 0

        let bag = Bag<AbsoluteSignal<String>>()
        let observer1 = { (signal: AbsoluteSignal<String>) in
            XCTAssertEqual(observerIndex, 0)
            observerIndex += 1
        }
        let observer2 = { (signal: AbsoluteSignal<String>) in
            XCTAssertEqual(observerIndex, 1)
            observerIndex += 1
        }
        let observer3 = { (signal: AbsoluteSignal<String>) in
            XCTAssertEqual(observerIndex, 2)
            observerIndex += 1
        }

        // Insert observers
        _ = bag.insert(observer1)
        _ = bag.insert(observer2)
        _ = bag.insert(observer3)
        // Broadcast
        bag.broadcast(.closed)

        // Assert
        XCTAssertEqual(observerIndex, 3)
    }

    static let allTests = [
        ("testInsertObserver", testInsertObserver),
        ("testRemoveObserver", testRemoveObserver),
        ("testBroadcastSignal", testBroadcastSignal),
        ("testBroadcastSignalInSequence", testBroadcastSignalInSequence)
    ]
}
