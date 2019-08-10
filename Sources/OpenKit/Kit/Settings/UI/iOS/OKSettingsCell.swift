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

private let imageSize : CGFloat = 29

public class OKSettingsCell : UITableViewCell {
    private var setting : OKSettings.Setting!
    private var type : OKSettingable.Type!
    private var object : OKSettingable?
    
    override public init(style : UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    public func set(setting : OKSettings.Setting, type : OKSettingable.Type, object : OKSettingable?) {
        self.setting = setting
        self.type = type
        self.object = object
        
        reload()
    }
    
    func updateStyle() {
        let isActionColor = setting.type.getTextColorIsActionColor(for: type, object: object)
        self.textLabel?.textColor = isActionColor ? OKAppearance.Style.shared.tintColor : OKAppearance.Style.shared.secondaryColor
    }
    
    private func reload() {
        self.textLabel?.text = setting.title
        
        imageView?.image = setting.image?.getRaw(standardSize: imageSize)
        
        let type = setting.type
        
        self.detailTextLabel?.text = type.getSubtitle(for: self.type, object: object)
        
        if type.getShowsDisclosureIndicator(for: self.type, object: object) {
            self.accessoryType = .disclosureIndicator
            self.accessoryView = nil
        } else {
            self.accessoryType = .none
            self.accessoryView = type.getAccessoryView(for: self.type, object: object)
        }
        
        self.selectionStyle = type.getShowsSelection(for: self.type, object: object) ? .default : .none
        
        updateStyle()
    }
    
    override public func observeValue(forKeyPath keyPath : String?, of object : Any?, change: [NSKeyValueChangeKey : Any]?, context : UnsafeMutableRawPointer?) {
        self.reload()
    }
    
    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal class OKSettingsSwitch : UISwitch {
    let key : String
    let type : OKSettingable.Type
    let object : OKSettingable?
    
    init(key : String, type : OKSettingable.Type, object : OKSettingable?) {
        self.key = key
        self.type = type
        self.object = object
        
        super.init(frame: .zero)
        
        updateValue()
        self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    func updateValue() {
        isOn = OKSettings.shared.get(forKey: key, type: type, object: object) as? Bool ?? false
    }
    
    @objc func valueChanged() {
        OKSettings.shared.set(isOn as AnyObject, forKey: key, type: type, object: object)
    }
    
    required init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
