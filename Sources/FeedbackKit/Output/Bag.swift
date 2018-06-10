//
//  Bag.swift
//  FeedbackKit
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

import Foundation

/// Observer token.
public typealias ObserverToken = String

/// Manage cluster of observers.
open class Bag<T: Value> {

    /// Observers.
    open private(set) var observers: [(token: ObserverToken, observer: (T) -> Void)] = []

    /// Insert observer.
    ///
    /// - Parameter observer: Observer to insert.
    /// - Returns: Token for observer.
    open func insert(_ observer: @escaping (T) -> Void) -> ObserverToken {
        let token = UUID().uuidString
        observers.append((token, observer))
        return token
    }

    /// Remove observer for token.
    ///
    /// - Parameter token: Observer token to remove.
    open func removeObserver(withToken token: ObserverToken) {
        observers = observers.filter { $0.token != token }
    }

    /// Broadcast value.
    ///
    /// - Parameter value: Value to broadcast.
    open func broadcast(_ value: T) {
        observers.forEach { $0.observer(value) }
    }
}
