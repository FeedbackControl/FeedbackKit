//
//  Processor.swift
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

/// Processor.
open class Processor<W: WireLabel>: WireDelegate {

    /// Wires.
    private var wires: [String: Wire<W>] = [:]

    /// Register wire.
    ///
    /// - Parameter wire: Wire to register.
    open func register(_ wire: Wire<W>) {
        wires[wire.label.rawValue] = wire
    }

    /// Get wire.
    ///
    /// - Parameter label: Label for wire.
    /// - Returns: Wire with the label.
    open func wire(withLabel label: W) -> Wire<W>? {
        return wires[label.rawValue]
    }

    /// Wire did connect component.
    ///
    /// - Parameters:
    ///   - wire: Wire.
    ///   - component: Connected component.
    open func wire<W: WireLabel>(_ wire: Wire<W>,
                                 didConnectComponent component: Component) {
        // Track changes.
    }
}
