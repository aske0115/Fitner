//
//  Error.swift
//  FitStrap
//
//  Created by Aske on 2023/01/17.
//

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    
    var message: String {
        switch self {
        case .decode:
            return "Decode Error"
        default:
            return "unknonw Error"
    }
}
