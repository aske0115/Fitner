//
//  ExerciseEndpoint.swift
//  FitStrap
//
//  Created by 1101249 on 1/24/23.
//

enum ExerciseEndpoint {
    case all
}

extension ExerciseEndpoint: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/exercises"
        }
    }
    
    var host: String {
        "exercisedb.p.rapidapi.com"
    }
    
    var method: RequestMethod {
        switch self {
        case .all:
            return .get
        }
    }
    
    var header: [String : String]? {
        let apiKey = "f572e711c6msh49cda1befe0395ep1a3bb5jsndca9cd6d9b78"
        switch self {
        case .all:
            return ["X-RapidAPI-Key": apiKey,
                "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .all:
            return nil
        }
    }
}
