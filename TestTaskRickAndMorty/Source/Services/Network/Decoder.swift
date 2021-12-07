//
//  Decoder.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 07.12.2021.
//

import Foundation

protocol CustomDecoder {
    var decoder: JSONDecoder { get }
}

final class JSONDecoderCustom: CustomDecoder {
    private(set) var decoder = JSONDecoder()
    
    init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
    }
}
