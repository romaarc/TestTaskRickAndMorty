//
//  CharacterCDModel+CoreDataProperties.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 16.12.2021.
//
//

import Foundation
import CoreData

extension CharacterCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterCDModel> {
        return NSFetchRequest<CharacterCDModel>(entityName: PersistentConstants.characterModel)
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var status: String
    @NSManaged public var species: String
    @NSManaged public var type: String
    @NSManaged public var gender: String
    @NSManaged public var origin: [String: String]
    @NSManaged public var location: [String: String]
    @NSManaged public var image: String
    @NSManaged public var episode: [String]
    @NSManaged public var created: Date
    @NSManaged public var page: Int16
    @NSManaged public var url: String
    
}

extension CharacterCDModel : Identifiable {}
