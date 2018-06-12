//
//  InputWire.swift
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

/// Wire wrapping inputs.
open class InputWire<W: WireLabel, I: InputLabel>: Wire<W>, InputHandler {

    public typealias IH = InputWire<W, I>

    /// Inputs.
    private var inputs: [String: Any] = [:]

    /// Initialize input wire.
    ///
    /// - Parameters:
    ///   - label: Input wire label.
    ///   - inputs: Inputs.
    public convenience init(label: W, inputs: [String: Any]) {
        self.init(label: label)
        self.inputs = inputs
    }

    /// Fabricate input.
    ///
    /// - Parameters:
    ///   - label: Input label.
    ///   - feedback: Feedback block.
    open func fabricateInput<T: Value>(label: I, feedback: @escaping (T) -> Void) {
        let input = Input<T>(feedback: feedback)
        inputs[label.rawValue] = input
    }

    /// Get input for label.
    ///
    /// - Parameter label: Input label.
    /// - Returns: Input for label.
    open func input<T: Value>(withLabel label: I) -> Input<T>? {
        return inputs[label.rawValue] as? Input<T>
    }

    /// Return sub input wire.
    ///
    /// - Parameter inputLabels: Input labels sub input wire have.
    /// - Returns: Sub input wire.
    open func subwire(withInputLabels inputLabels: [I]) -> InputWire<W, I> {
        let inputLabelRawValues = inputLabels.map { $0.rawValue }
        let filteredInputs = inputs.filter({ inputLabelRawValues.contains($0.key) })
        let subwire = InputWire<W, I>(label: label, inputs: filteredInputs)
        append(subwire)
        return subwire
    }
}
