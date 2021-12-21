//
//  CharacterFilterCDModel+CoreDataProperties.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 20.12.2021.
//
//

import Foundation
import CoreData

extension CharacterFilterCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterFilterCDModel> {
        return NSFetchRequest<CharacterFilterCDModel>(entityName: PersistentConstants.characterFilterModel)
    }

    @NSManaged public var id: Int64
    @NSManaged public var created: Date
    @NSManaged public var episode: Array<String>
    @NSManaged public var gender: String
    @NSManaged public var image: String
    @NSManaged public var location: Dictionary<String, String>
    @NSManaged public var url: String
    @NSManaged public var type: String
    @NSManaged public var species: String
    @NSManaged public var origin: Dictionary<String, String>
    @NSManaged public var name: String
    @NSManaged public var page: Int16
    @NSManaged public var status: String

}

extension CharacterFilterCDModel : Identifiable {}
