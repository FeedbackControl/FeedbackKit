//
//  DuplexWire.swift
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

/// Wire wrapping inputs and outputs.
open class DuplexWire<W: WireLabel, I: InputLabel, O: OutputLabel>: Wire<W>, InputHandler, OutputHandler {

    public typealias OH = OutputWire<W, O>

    /// Inputs.
    private var inputs: [String: Any] = [:]
    /// Outputs.
    private var outputs: [String: Any] = [:]

    /// Initialize input wire.
    ///
    /// - Parameters:
    ///   - label: Input wire label.
    ///   - inputs: Inputs.
    ///   - outputs: Outputs.
    public convenience init(label: W, inputs: [String: Any], outputs: [String: Any]) {
        self.init(label: label)
        self.inputs = inputs
        self.outputs = outputs
    }

    /// Fabricate input.
    ///
    /// - Parameters:
    ///   - label: Input label.
    ///   - feedback: Feedback block.
    open func fabricateInput<T>(label: I, feedback: @escaping (T) -> Void) {
        let input = Input<T>(feedback: feedback)
        inputs[label.rawValue] = input
    }

    /// Get input for label.
    ///
    /// - Parameter label: Input label.
    /// - Returns: Input for label.
    open func input<T>(withLabel label: I) -> Input<T>? {
        return inputs[label.rawValue] as? Input<T>
    }

    /// Fabricate output and get paired output pin.
    ///
    /// - Parameters:
    ///   - label: Output label.
    ///   - initialValue: Output initial value.
    /// - Returns: Paired output pin.
    open func fabricateOutput<T: Value>(label: O, initialValue: T) -> OutputPin<T> {
        let (outputPin, output) = OutputPin<T>.fabricate(initialValue: initialValue)
        outputs[label.rawValue] = output
        return outputPin
    }

    /// Get output for label.
    ///
    /// - Parameter label: Output label.
    /// - Returns: Output for label.
    open func output<T: Value>(withLabel label: O) -> Output<T>? {
        return outputs[label.rawValue] as? Output<T>
    }

    /// Return sub input wire.
    ///
    /// - Parameter inputLabels: Input labels sub input wire have.
    /// - Returns: Sub input wire.
    open func subwire(withInputLabels inputLabels: [I]) -> InputWire<W, I> {
        let inputLabelRawValues = inputLabels.map { $0.rawValue }
        let filteredInputs = inputs.filter { inputLabelRawValues.contains($0.key) }
        let subwire = InputWire<W, I>(label: label, inputs: filteredInputs)
        append(subwire)
        return subwire
    }

    /// Return sub output wire.
    ///
    /// - Parameter outputLabels: Output labels sub output wire have.
    /// - Returns: Sub output wire.
    open func subwire(withOutputLabels outputLabels: [O]) -> OutputWire<W, O> {
        let outputLabelRawValues = outputLabels.map { $0.rawValue }
        let filteredOutputs = outputs.filter { outputLabelRawValues.contains($0.key) }
        let subwire = OutputWire<W, O>(label: label, outputs: filteredOutputs)
        append(subwire)
        return subwire
    }

    /// Return sub duplex wire.
    ///
    /// - Parameters:
    ///   - inputLabels: Input labels sub wire have.
    ///   - outputLabels: Output labels sub wire have.
    /// - Returns: Sub duplex wire.
    open func subwire(inputLabels: [I] = [], outputLabels: [O] = []) -> DuplexWire<W, I, O> {
        let inputLabelRawValues = inputLabels.map { $0.rawValue }
        let filteredInputs = inputs.filter { inputLabelRawValues.contains($0.key) }
        let outputLabelRawValues = outputLabels.map { $0.rawValue }
        let filteredOutputs = outputs.filter { outputLabelRawValues.contains($0.key) }
        let subwire = DuplexWire<W, I, O>(label: label, inputs: filteredInputs, outputs: filteredOutputs)
        append(subwire)
        return subwire
    }
}
