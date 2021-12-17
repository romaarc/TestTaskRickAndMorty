//
//  InfoCDModel+CoreDataProperties.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 16.12.2021.
//
//

import Foundation
import CoreData

extension InfoCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoCDModel> {
        return NSFetchRequest<InfoCDModel>(entityName: PersistentConstants.infoModel)
    }

    @NSManaged public var characterCount: Int16
    @NSManaged public var characterPages: Int16
    @NSManaged public var locationPages: Int16
    @NSManaged public var locationCount: Int16
    @NSManaged public var episodeCount: Int16
    @NSManaged public var episodePages: Int16

}

extension InfoCDModel : Identifiable {}
