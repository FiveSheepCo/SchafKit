//  Copyright (c) 2015 - 2019 Jann Schafranek
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

import Foundation

extension OKAlerting {
    /// An action to be used on alert prompts across iOS, tvOS, watchOS and macOS.
    public struct Action {
        let title : String
        let style : Style
        let handler : Block?
        
        /// Initializes a new action.
        public init(title : String,
                    style : Style = .default,
                    handler : Block? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
        
        internal static func constructOKAction(handler : Block?) -> Action {
            return Action(title: "OK".localized, handler: handler)
        }
        
        internal static func constructCancelAction(handler : Block?) -> Action {
            return Action(title: "Cancel".localized, style: .cancel, handler: handler)
        }
    }
}
