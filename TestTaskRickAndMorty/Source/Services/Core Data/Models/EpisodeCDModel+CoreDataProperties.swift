//
//  EpisodeCDModel+CoreDataProperties.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 17.12.2021.
//
//

import Foundation
import CoreData

extension EpisodeCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EpisodeCDModel> {
        return NSFetchRequest<EpisodeCDModel>(entityName: PersistentConstants.episodeModel)
    }

    @NSManaged public var page: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var airDate: String
    @NSManaged public var episode: String
    @NSManaged public var characters: Array<String>?
    @NSManaged public var created: Date
    @NSManaged public var url: String

}

extension EpisodeCDModel : Identifiable {

}
