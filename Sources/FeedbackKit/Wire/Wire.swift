//
//  Wire.swift
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

/// Wire.
open class Wire<W: WireLabel> {

    /// Processor.
    public let processor: Processor<W>?

    /// Subwires.
    open var subwires: [Wire<W>] {
        return subwireHashes.allObjects
    }
    /// Components.
    open var components: [Component] {
        return componentHashes.allObjects as! [Component]
    }

    /// Subwire hash table.
    private let subwireHashes = NSHashTable<Wire<W>>.weakObjects()
    /// Component hash table.
    private let componentHashes = NSHashTable<AnyObject>.weakObjects()

    /// Wire label.
    public let label: W

    /// Initialize wire.
    ///
    /// - Parameter label: Wire label.
    public init(label: W, processor: Processor<W>? = nil) {
        self.label = label
        self.processor = processor
    }

    /// Append subwire.
    ///
    /// - Parameter subwire: Subwire.
    open func append(_ subwire: Wire<W>) {
        subwireHashes.add(subwire)
    }

    /// Connect component and keep the reference.
    ///
    /// - Parameter component: Target component.
    open func connect(_ component: Component) {
        component.connect(self)
        componentHashes.add(component)
        processor?.wire(self, didConnectComponent: component)
    }
}
