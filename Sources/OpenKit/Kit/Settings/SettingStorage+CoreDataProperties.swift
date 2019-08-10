//
//  SettingStorage+CoreDataProperties.swift
//  OpenKit-iOS
//
//  Created by Jann on 10.08.19.
//  Copyright © 2019 Jann Schafranek. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingStorage> {
        return NSFetchRequest<SettingStorage>(entityName: "SettingStorage")
    }

    @NSManaged public var key: String?
    @NSManaged public var type: String?
    @NSManaged public var uuid: String?
    @NSManaged public var value: NSObject?

}
