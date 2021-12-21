//
//  PersistentProvider+Characters.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 16.12.2021.
//

import Foundation
import CoreData

extension PersistentProvider: PersistentProviderProtocol {
    //MARK: - Character table
    func update(with page: Int, where models: [Character], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void) {
        switch action  {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let characters = try? self.fetchRequest(for: $0).execute().first {
                        characters.update(with: $0, and: page, isUpdatingPage: false)
                        ///adding
                    } else {
                        let characterCD = CharacterCDModel(context: backgroundViewContext)
                        characterCD.configNew(with: $0, and: page)
                    }
                }
                saveContext()
            }
        case .update:
            break
        case .remove:
            break
        }
    }
    
    func fetchCharactersModels() -> [CharacterCDModel] {
        let request = CharacterCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [CharacterCDModel]() }
        return table
    }
    
    func fetchCharactersModels(with page: Int) -> [CharacterCDModel] {
        let request = CharacterCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "page == %i", page)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [CharacterCDModel]() }
        return table
    }
    
    func fetchCharactersModels(by urls: [String]) -> [CharacterCDModel] {
        let request = CharacterCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "url IN %@", urls)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [CharacterCDModel]() }
        return table
    }
    //MARK: - Info tabble
    func update(with page: Int, and count: Int, where action: PersistentInfo) {
        switch action {
        case .characters:
            backgroundViewContext.performAndWait {
                ///updating
                if let info = try? InfoCDModel.fetchRequest().execute().first {
                    info.update(with: page, and: count, where: .characters)
                    ///adding
                } else {
                    let infoCD = InfoCDModel(context: backgroundViewContext)
                    infoCD.configNew(with: page, and: count, where: .characters)
                }
                saveContext()
            }
        case .locations:
            backgroundViewContext.performAndWait {
                ///updating
                if let info = try? InfoCDModel.fetchRequest().execute().first {
                    info.update(with: page, and: count, where: .locations)
                }
                saveContext()
            }
        case .episodes:
            backgroundViewContext.performAndWait {
                ///updating
                if let info = try? InfoCDModel.fetchRequest().execute().first {
                    info.update(with: page, and: count, where: .episodes)
                }
                saveContext()
            }
        }
    }
    
    func fetchInfoModels() -> [InfoCDModel] {
        let request = InfoCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [InfoCDModel]() }
        return table
    }
    //MARK: - Location table
    func update(with page: Int, where models: [Location], and action: PersistentState) {
        switch action {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let locations = try? self.fetchRequest(for: $0).execute().first {
                        locations.update(with: $0, and: page)
                        ///adding
                    } else {
                        let locationCD = LocationCDModel(context: backgroundViewContext)
                        locationCD.configNew(with: $0, and: page)
                    }
                }
                saveContext()
            }
        case .remove:
            break
        case .update:
            break
        }
    }
    
    func fetchLocationModels(with page: Int) -> [LocationCDModel] {
        let request = LocationCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "page == %i", page)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [LocationCDModel]() }
        return table
    }
    
    func fetchLocationModel(by url: String) -> [LocationCDModel] {
        let request = LocationCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "url == %@", url)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [LocationCDModel]() }
        return table
    }
    //MARK: - Episode tabel
    func update(with page: Int, where models: [Episode], and action: PersistentState) {
        switch action {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let episodes = try? self.fetchRequest(for: $0).execute().first {
                        episodes.update(with: $0, and: page)
                        ///adding
                    } else {
                        let episodeCD = EpisodeCDModel(context: backgroundViewContext)
                        episodeCD.configNew(with: $0, and: page)
                    }
                }
                saveContext()
            }
        case .remove:
            break
        case .update:
            break
        }
    }
    
    func fetchEpisodeModels(with page: Int) -> [EpisodeCDModel] {
        let sort = NSSortDescriptor(key: "id", ascending: true)
        let request = EpisodeCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "page == %i", page)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [EpisodeCDModel]() }
        return table
    }
    
    func fetchEpisodeModels(by urls: [String]) -> [EpisodeCDModel] {
        let request = EpisodeCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "url IN %@", urls)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [EpisodeCDModel]() }
        return table
    }
    //MARK: - Character Filter table
    func updateFilter(with page: Int, where models: [Character], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void) {
        switch action  {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let characters = try? self.fetchRequestFilter(for: $0, and: page).execute().first {
                        characters.update(with: $0, and: page, isUpdatingPage: false)
                        ///adding
                    } else {
                        let characterCD = CharacterFilterCDModel(context: backgroundViewContext)
                        characterCD.configNew(with: $0, and: page)
                    }
                }
                saveContext()
            }
        case .update:
            break
        case .remove:
            break
        }
    }
    
    func fetchCharactersFilterModels(with params: CharacterURLParameters, and page: Int) -> [CharacterFilterCDModel] {
        let request  = CharacterFilterCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 20
        var arrayParams: [CharacterURLParameters] = []
        arrayParams.append(params)
        var predicates: [NSPredicate] = []
        predicates.append(NSPredicate(format: "page == %i", page))
        for param in arrayParams {
            if let name = param.name {
                if !name.isEmpty {
                    predicates.append(NSPredicate(format: "name CONTAINS %@", name)) //LIKE '*%1$@*'
                }
            }
            if let gender = param.gender {
                if !gender.isEmpty {
                    predicates.append(NSPredicate(format: "gender CONTAINS %@", gender.capitalized))
                }
            }
            if let status = param.status {
                if !status.isEmpty {
                    predicates.append(NSPredicate(format: "status CONTAINS %@", status.capitalized))
                }
            }
        }
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = predicate
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [CharacterFilterCDModel]() }
        return table
    }
    
    func fetchCharactersFilterModels(with params: CharacterURLParameters) -> [CharacterFilterCDModel] {
        let request  = CharacterFilterCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.returnsDistinctResults = true
        var arrayParams: [CharacterURLParameters] = []
        arrayParams.append(params)
        var predicates: [NSPredicate] = []
        for param in arrayParams {
            if let name = param.name {
                if !name.isEmpty {
                    predicates.append(NSPredicate(format: "name CONTAINS %@", name)) //LIKE '*%1$@*'
                }
            }
            if let gender = param.gender {
                if !gender.isEmpty {
                    predicates.append(NSPredicate(format: "gender CONTAINS %@", gender.capitalized))
                }
            }
            if let status = param.status {
                if !status.isEmpty {
                    predicates.append(NSPredicate(format: "status CONTAINS %@", status.capitalized))
                }
            }
        }
        if predicates.count == 1 {
            request.predicate = predicates[0]
        } else {
            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.predicate = predicate
        }
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = predicate
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [CharacterFilterCDModel]() }
        return table
    }
}
//MARK: - FetchRequest with id CD Model Character and extension CharacterCDModel
private extension PersistentProvider {
    func fetchRequest(for character: Character) -> NSFetchRequest<CharacterCDModel> {
        let request = CharacterCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", character.id)
        return request
    }
    func fetchRequestFilter(for character: Character, and page: Int) -> NSFetchRequest<CharacterFilterCDModel> {
        let request = CharacterFilterCDModel.fetchRequest()
        var predicates: [NSPredicate] = []
        predicates.append(.init(format: "id == %i", character.id))
        predicates.append(.init(format: "page == %i", page))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return request
    }
}

fileprivate extension CharacterCDModel {
    func update(with character: Character, and characterPage: Int, isUpdatingPage: Bool) {
        var originDict: [String: String] = [:]
        var locationDict: [String: String] = [:]
        
        if isUpdatingPage {
            page = Int16(characterPage)
        }
        name = character.name
        status = character.status.lowercased().capitalized
        species = character.species
        type = character.type
        gender = character.gender.lowercased().capitalized
        
        originDict[character.origin.name] = character.origin.url
        origin = originDict
        
        locationDict[character.location.name] = character.location.url
        location = locationDict
        
        image = character.imageURL
        episode = character.episode
        created = character.created
        url = character.url
    }
    
    func configNew(with character: Character, and characterPage: Int) {
        id = Int64(character.id)
        update(with: character, and: characterPage, isUpdatingPage: true)
    }
}

fileprivate extension CharacterFilterCDModel {
    func update(with character: Character, and characterPage: Int, isUpdatingPage: Bool) {
        var originDict: [String: String] = [:]
        var locationDict: [String: String] = [:]
        
        if isUpdatingPage {
            page = Int16(characterPage)
        }
        name = character.name
        status = character.status.lowercased().capitalized
        species = character.species
        type = character.type
        gender = character.gender.lowercased().capitalized
        
        originDict[character.origin.name] = character.origin.url
        origin = originDict
        
        locationDict[character.location.name] = character.location.url
        location = locationDict
        
        image = character.imageURL
        episode = character.episode
        created = character.created
        url = character.url
    }
    
    func configNew(with character: Character, and characterPage: Int) {
        id = Int64(character.id)
        update(with: character, and: characterPage, isUpdatingPage: true)
    }
}

//MARK: -  CD Model Info
fileprivate extension InfoCDModel {
    func update(with page: Int, and count: Int, where action: PersistentInfo) {
        switch action {
        case .characters:
            characterCount = Int16(count)
            characterPages = Int16(page)
        case .locations:
            locationCount = Int16(count)
            locationPages = Int16(page)
        case .episodes:
            episodeCount = Int16(count)
            episodePages = Int16(page)
        }
    }
    
    func configNew(with page: Int, and count: Int, where action: PersistentInfo) {
        update(with: page, and: count, where: action)
    }
}

//MARK: - FetchRequest with id CD Model Location and extension LocationCDModel
private extension PersistentProvider {
    func fetchRequest(for location: Location) -> NSFetchRequest<LocationCDModel> {
        let request = LocationCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", location.id)
        return request
    }
}

fileprivate extension LocationCDModel {
    func update(with loc: Location, and locationPage: Int) {
        page = Int16(locationPage)
        name = loc.name
        type = loc.type
        dimension = loc.dimension
        residents = loc.residents
        created = loc.created
        url = loc.url
    }
    
    func configNew(with loc: Location, and locationPage: Int) {
        id = Int16(loc.id)
        update(with: loc, and: locationPage)
    }
}
//MARK: - FetchRequest with id CD Model Episode and extension EpisodeCDModel
private extension PersistentProvider {
    func fetchRequest(for episode: Episode) -> NSFetchRequest<EpisodeCDModel> {
        let request = EpisodeCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", episode.id)
        return request
    }
}

fileprivate extension EpisodeCDModel {
    func update(with epi: Episode, and episodePage: Int) {
        page = Int16(episodePage)
        name = epi.name
        airDate = epi.airDate
        episode = epi.episode
        characters = epi.characters
        created = epi.created
        url = epi.url
    }
    
    func configNew(with epi: Episode, and episodePage: Int) {
        id = Int16(epi.id)
        update(with: epi, and: episodePage)
    }
}
