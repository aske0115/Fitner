//
//  Exercise.swift
//  FitStrap
//
//  Created by 1101249 on 1/24/23.
//

import Foundation

struct Exercise: Codable, Hashable {
    let identifire: UUID = UUID()
    let bodyPart: String
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
    
    
    enum CodingKeys: String, CodingKey {
        case bodyPart, equipment, id, name, target, gifUrl
    }
}
