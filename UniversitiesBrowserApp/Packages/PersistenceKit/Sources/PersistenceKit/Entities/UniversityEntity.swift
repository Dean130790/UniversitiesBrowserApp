//
//  UniversityEntity.swift
//  PersistenceKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import CoreData

@objc(UniversityEntity)
public final class UniversityEntity: NSManagedObject {

}

extension UniversityEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniversityEntity> {
        NSFetchRequest<UniversityEntity>(entityName: "UniversityEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var alphaTwoCode: String
    @NSManaged public var name: String
    @NSManaged public var country: String
    @NSManaged public var stateProvince: String?
    @NSManaged public var domains: NSArray?
    @NSManaged public var webPages: NSArray?
}
