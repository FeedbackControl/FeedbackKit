//
//  Output.swift
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

/// Output stream.
open class Output<T: Value> {

    /// Output signal.
    open var value: T {
        return outputPin.value
    }

    /// Paired output pin.
    private let outputPin: OutputPin<T>
    /// Paired bag.
    private let bag: Bag<T>

    /// Initialize output.
    ///
    /// - Parameters:
    ///   - outputPin: Paired output pin.
    ///   - bag: Paired bag.
    public init(outputPin: OutputPin<T>, bag: Bag<T>) {
        self.outputPin = outputPin
        self.bag = bag
    }

    /// Observe value with observer block.
    ///
    /// - Parameter observer: Observer block to be
    ///                       executed on value change.
    /// - Returns: Disposable disposing observer.
    @discardableResult
    open func observe(_ observer: @escaping (T) -> Void) -> Disposable {
        let token = bag.insert(observer)
        return Disposable { [weak self] in
            self?.bag.removeObserver(withToken: token)
        }
    }
}
