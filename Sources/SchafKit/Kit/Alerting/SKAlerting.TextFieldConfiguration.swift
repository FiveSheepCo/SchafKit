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

extension SKAlerting {
    /// A text field configuration to be used on alert prompts across iOS, tvOS, watchOS and macOS.
    public struct TextFieldConfiguration {
        internal let placeholder : String
        internal let text : String?
        internal let isPassword : Bool
        
        /**
         Initializes a new `SKAlerting.TextFieldConfiguration`.
         
         - Parameters:
         - placeholder : The placeholder.
         - text : The text. Default is `nil`.
         - isPassword : Whether the configuration is for a text field in which a password will be entered.
         */
        public init(placeholder : String,
                    text : String? = nil,
                    isPassword : Bool = false) {
            self.placeholder = placeholder
            self.isPassword = isPassword
            self.text = text
        }
    }
}
