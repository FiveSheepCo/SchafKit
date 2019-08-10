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

#if os(iOS)
import UIKit

private extension UIView {
    func updateAllSuperTableViews(animated : Bool = true) {
        if let tableView = self as? UITableView {
            tableView.update(animated: animated)
        }
        
        self.superview?.updateAllSuperTableViews(animated: animated)
    }
}

/// A text view that automatically resizes itself according to its content and has a placeholder.
public class OKAdvancedTextView : UIView, UITextViewDelegate {
    /// Whether the TextView automatically updates `UITableView`s it is contained in.
    public var automaticallyUpdatesTableViews : Bool = true
    
    private var changeHandler : OKBlock?
    
    private let _textView = UITextView()
    private let _placeholderTextView = UITextView()
    
    /// Initializes a new `OKAdvancedTextView` with a change handler that is called when its dimension changes.
    public convenience init (changeHandler : @escaping OKBlock) {
        self.init(frame: .zero)
        
        self.changeHandler = changeHandler
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(OKAdvancedTextView.textChanged), name: UITextView.textDidChangeNotification, object: _textView)
        
        _textView.backgroundColor = .clear
        _textView.isScrollEnabled = false
        _textView.textContainerInset = .zero
        
        _placeholderTextView.backgroundColor = .clear
        _placeholderTextView.isScrollEnabled = false
        _placeholderTextView.isUserInteractionEnabled = false
        _placeholderTextView.textContainerInset = .zero
        
        _textView.translatesAutoresizingMaskIntoConstraints = false
        _placeholderTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(_textView)
        self.addSubview(_placeholderTextView)
        
        NSLayoutConstraint.activate([
            _textView.topAnchor.constraint(equalTo: self.topAnchor),
            _textView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _textView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            _placeholderTextView.topAnchor.constraint(equalTo: self.topAnchor),
            _placeholderTextView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        placeholderTextColor = OKAppearance.Style.shared.minimumContrastColor
        
        textChanged()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.textChanged()
    }
    
    private var hasChanged : Bool = false
    @objc func textChanged() {
        let hadChanged = hasChanged
        hasChanged = true
        
        _placeholderTextView.isHidden = _textView.text?.count ?? 0 > 0
        
        let newHeight = _textView.sizeThatFits(CGSize(width: self.frame.size.width, height: .greatestFiniteMagnitude)).height
        
        if newHeight == self.frame.size.height {
            return
        }
        
        self.frame.size.height = newHeight
        
        if automaticallyUpdatesTableViews && hadChanged {
            self.updateAllSuperTableViews(animated: false)
        }
        
        changeHandler?()
    }
    
    /// Call this function when the `UITableViewCell` containig the receiver was dequeued.
    ///
    /// - Note: You might call this in the `prepareForReuse` function of the containing cell.
    /// - Important: This prohibits the receiver from trying to force update the UITableView the next time its height changes. Not calling this function can result in the tableview stuttering.
    public func containingCellWasDequeued() {
        hasChanged = false
    }
    
    /// Whether the receiver represents the given UITextView.
    public func represents(rhs : UITextView) -> Bool {
        return rhs == _textView
    }
    
    // MARK: - Synthetic Properties
    
    /**
     The text displayed by the text view.
     
     Assigning a new value to this property also replaces the value of the attributedText property with the same text, albeit without any inherent style attributes. Instead the text view styles the new string using the font, textColor, and other style-related properties of the class.
    */
    public var text : String? {
        get { return _textView.text }
        set { _textView.text = newValue ; textChanged() ; delegate?.textViewDidChange?(_textView) }
    }
    
    /**
     The styled text displayed by the text view.
     
     Assigning a new value to this property also replaces the value of the attributedText property with the same text, albeit without any inherent style attributes. Instead the text view styles the new string using the font, textColor, and other style-related properties of the class.
     */
    public var attributedText : NSAttributedString? {
        get { return _textView.attributedText }
        set { _textView.attributedText = newValue ; textChanged() ; delegate?.textViewDidChange?(_textView) }
    }
    
    /**
     The font of the text.
     
     This property applies to the entire text string. The default value of this property is the body style of the system font.
     
     - note: You can get information about the fonts available on the system using the methods of the UIFont class.
     
     Assigning a new value to this property causes the new font to be applied to the entire contents of the text view. If you want to apply the font to only a portion of the text, you must create a new attributed string with the desired style information and assign it to the attributedText property.
     */
    public var font : UIFont? {
        get { return _textView.font }
        set { _textView.font = newValue ; _placeholderTextView.font = newValue ; textChanged() }
    }
    
    /**
     The color of the text.
     
     This property applies to the entire text string. The default text color is black.
     
     Assigning a new value to this property causes the new text color to be applied to the entire contents of the text view. If you want to apply the color to only a portion of the text, you must create a new attributed string with the desired style information and assign it to the attributedText property.
     */
    public var textColor : UIColor? {
        get { return _textView.textColor }
        set { _textView.textColor = newValue }
    }
    
    /**
     The appearance style of the keyboard that is associated with the text object.
     
     This property lets you distinguish between the default text entry inside your application and text entry inside an alert panel. The default value for this property is UIKeyboardAppearance.default.
     */
    public var keyboardAppearance : UIKeyboardAppearance {
        get { return _textView.keyboardAppearance }
        set { _textView.keyboardAppearance = newValue }
    }
    
    /**
     The visible title of the Return key.
     
     Setting this property to a different key type changes the visible title of the Return key and typically results in the keyboard being dismissed when it is pressed. The default value for this property is UIReturnKeyType.default.
     */
    public var returnKeyType : UIReturnKeyType {
        get { return _textView.returnKeyType }
        set { _textView.returnKeyType = newValue }
    }
    
    /**
     The receiver’s delegate.
     
     A text view delegate responds to editing-related messages from the text view. You can use the delegate to track changes to the text itself and to the current selection.
     
     For information about the methods implemented by the delegate, see `UITextViewDelegate`.
     */
    public var delegate : UITextViewDelegate? {
        get { return _textView.delegate }
        set { _textView.delegate = newValue }
    }
    
    /**
     A Boolean value indicating whether the receiver is editable.
     
     The default value of this property is true.
     */
    public var isEditable : Bool {
        get { return _textView.isEditable }
        set { _textView.isEditable = newValue }
    }
    
    /**
     A Boolean value indicating whether the receiver is selectable.
     
     This property controls the ability of the user to select content and interact with URLs and text attachments. The default value is true.
     */
    public var isSelectable : Bool {
        get { return _textView.isSelectable }
        set { _textView.isSelectable = newValue }
    }
    
    /**
     The current selection range of the receiver.
     */
    public var selectedRange : NSRange {
        get { return _textView.selectedRange }
        set { _textView.selectedRange = newValue }
    }
    
    /**
     The keyboard style associated with the text object.
     
     Text objects can be targeted for specific types of input, such as plain text, email, numeric entry, and so on. The keyboard style identifies what keys are available on the keyboard and which ones appear by default. The default value for this property is UIKeyboardType.default.
     */
    public var keyboardType : UIKeyboardType {
        get { return _textView.keyboardType }
        set { _textView.keyboardType = newValue }
    }
    
    /**
     The autocorrection style for the text object.
     
     This property determines whether autocorrection is enabled or disabled during typing. With autocorrection enabled, the text object tracks unknown words and suggests a more suitable replacement candidate to the user, replacing the typed text automatically unless the user explicitly overrides the action.
     
     The default value for this property is UITextAutocorrectionType.default, which for most input methods results in autocorrection being enabled.
     */
    public var autocorrectionType : UITextAutocorrectionType {
        get { return _textView.autocorrectionType }
        set { _textView.autocorrectionType = newValue }
    }
    
    /**
     The auto-capitalization style for the text object.
     
     This property determines at what times the Shift key is automatically pressed, thereby making the typed character a capital letter. The default value for this property is UITextAutocapitalizationType.sentences.
     
     Some keyboard types do not support auto-capitalization. Specifically, this option is ignored if the value in the keyboardType property is set to UIKeyboardType.numberPad, UIKeyboardType.phonePad, or UIKeyboardType.namePhonePad.
     */
    public var autocapitalizationType : UITextAutocapitalizationType {
        get { return _textView.autocapitalizationType }
        set { _textView.autocapitalizationType = newValue }
    }
    
    /**
     The text container object defining the area in which text is displayed in this text view.
     */
    public var textContainer : NSTextContainer {
        get { return _textView.textContainer }
    }
    
    /**
     Returns a Boolean value indicating whether this object is the first responder.
     
     UIKit dispatches some types of events, such as motion events, to the first responder initially.
     */
    public override var isFirstResponder: Bool {
        return _textView.isFirstResponder
    }
    
    /**
     Asks UIKit to make this object the first responder in its window.
     
     Call this method when you want the current object to be the first responder. Calling this method is not a guarantee that the object will become the first responder. UIKit asks the current first responder to resign as first responder, which it might not. If it does, UIKit calls this object's canBecomeFirstResponder method, which returns false by default. If this object succeeds in becoming the first responder, subsequent events targeting the first responder are delivered to this object first and UIKit attempts to display the object's input view, if any.
     
     Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy.
     
     You can override this method in your custom responders to update your object's state or perform some action such as highlighting the selection. If you override this method, you must call super at some point in your implementation.
     */
    public override func becomeFirstResponder() -> Bool {
        return _textView.becomeFirstResponder()
    }
    
    /**
     Notifies this object that it has been asked to relinquish its status as first responder in its window.
     
     A text view delegate responds to editing-related messages from the text view. You can use the delegate to track changes to the text itself and to the current selection.
     
     For information about the methods implemented by the delegate, see `UITextViewDelegate`.
     */
    public override func resignFirstResponder() -> Bool {
        return _textView.resignFirstResponder()
    }
    
    // MARK: - Synthetic Placeholder Properties
    
    /**
     The text displayed as a placeholder if the user has not entered any characters.
     */
    public var placeholderText : String? {
        get { return _placeholderTextView.text }
        set { _placeholderTextView.text = newValue }
    }
    
    /**
     The color of the placeholder.
     */
    public var placeholderTextColor : UIColor? {
        get { return _placeholderTextView.textColor }
        set { _placeholderTextView.textColor = newValue }
    }
}

private extension UIView {
    func updateTableViews() {
        superview?.updateTableViews()
        
        if let tableview = self as? UITableView {
            tableview.update(animated: false)
        }
    }
}
#endif
