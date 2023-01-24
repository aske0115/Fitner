//
//  Error.swift
//  FitStrap
//
//  Created by Aske on 2023/01/17.
//
import Foundation

enum RequestError: Error {
    case decode
    case invalidURL(URL)
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var message: String {
        switch self {
        case .decode:
            return "Decode Error"
        case .invalidURL(let url):
            return "\(url) is invalidURL"
        default:
            return "unknonw Error"
        }
    }
}
