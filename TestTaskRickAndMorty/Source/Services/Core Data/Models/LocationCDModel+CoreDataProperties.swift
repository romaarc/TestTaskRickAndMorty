//
//  LocationCDModel+CoreDataProperties.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 16.12.2021.
//
//

import Foundation
import CoreData

extension LocationCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCDModel> {
        return NSFetchRequest<LocationCDModel>(entityName: PersistentConstants.locationModel)
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var dimension: String
    @NSManaged public var residents: Array<String>?
    @NSManaged public var created: Date
    @NSManaged public var page: Int16
    @NSManaged public var url: String
}

extension LocationCDModel : Identifiable {}
