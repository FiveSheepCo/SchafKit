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
#if os(iOS)
import UIKit

private func getType(from object : OKSettingable) -> OKSettingable.Type {
    return type(of: object)
}

public class OKSettingsController : UITableViewController, OKStyleReceiver {
    private static var standardPage : OKSettings.Page!
    private static var standardType : OKSettingable.Type!
    private static var standardObject : OKSettingable?
    
    public static func setStandard(page : OKSettings.Page, type : OKSettingable.Type, object : OKSettingable? = nil) {
        self.standardPage = page
        self.standardType = type
        self.standardObject = object
    }
    
    private var didLoad : Bool = false
    private var page : OKSettings.Page!
    private var type : OKSettingable.Type!
    private var object : OKSettingable?
    
    public init (page : OKSettings.Page, type : OKSettingable.Type, object : OKSettingable? = nil) {
        super.init(style: .grouped)
        
        set(page: page, type: type, object: object)
    }
    
    convenience public init(page : OKSettings.Page, object : OKSettingable) {
        self.init(page: page, type: getType(from: object), object: object)
    }
    
    convenience public init(type : OKSettingable.Type) {
        self.init(page: type.settingsMainPage, type: type)
    }
    
    required public init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        
        guard let standardPage = OKSettingsController.standardPage, let standardType = OKSettingsController.standardType else {
            return
        }
        self.set(page: standardPage, type: standardType, object: OKSettingsController.standardObject)
    }
    
    public func set(page : OKSettings.Page, type : OKSettingable.Type, object : OKSettingable? = nil) {
        self.page = page
        self.type = type
        self.object = object
        
        self.title = page.title
        
        reloadGroups()
        
        if didLoad {
            tableView.reloadData()
        }
    }
    
    public func updateStyle(_ style: OKAppearance.Style) {
        self.tableView.backgroundColor = style.tableViewHeaderFooterBackgroundColor
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        didLoad = true
        
        tableView.register(OKSettingsCell.classForCoder(), forCellReuseIdentifier: "SettingsCell")
        
        setupStyle()
    }
    
    override public func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        
        let isFirst = self.navigationController?.viewControllers.first == self
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = isFirst ? .automatic : .never
        }
        
        if isFirst && self.presentingViewController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        }
        
        reload()
    }
    
    @objc func done() {
        dismiss()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var groups : [OKSettings.Group] = []
    private var groupItems : [[OKSettings.Setting]] = []
    private func reloadGroups() {
        groups = page.groups
        groupItems = groups.map({ (group) -> [OKSettings.Setting] in
            return group.settingsGetter(object)
        })
    }
    
    internal func reload(animated : Bool = false) {
        reloadGroups()
        tableView.reloadSections(IndexSet(integersIn: 0..<tableView.numberOfSections), with: animated ? .automatic : .none)
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView : UITableView) -> Int {
        return groups.count
    }
    
    override public func tableView(_ tableView : UITableView, titleForHeaderInSection section : Int) -> String? {
        return groups[section].title
    }
    
    override public func tableView(_ tableView : UITableView, titleForFooterInSection section : Int) -> String? {
        return groups[section].subtitle
    }
    
    override public func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return groupItems[section].count
    }
    
    override public func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! OKSettingsCell
        
        cell.set(setting: groupItems[indexPath.section][indexPath.row], type: type, object: object)
        
        return cell
    }
    
    override public func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        let setting = groupItems[indexPath.section][indexPath.row]
        
        setting.type.didSelect(for: type, object: object, setting: setting, newValueHandler: { (key, value) in
            OKSettings.shared.set(value, forKey: key, type: self.type, object: self.object)
        })
    }
}
#endif
