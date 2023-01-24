//
//  EndPoint.swift
//  FitStrap
//
//  Created by Aske on 2023/01/17.
//

/*
 const options = {
   method: 'GET',
   url: 'https://exercisedb.p.rapidapi.com/exercises',
   headers: {
     
   }
 }
 */
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}


extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        ""
    }
}
