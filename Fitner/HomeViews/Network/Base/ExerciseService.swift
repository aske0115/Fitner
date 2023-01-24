//
//  ExerciseService.swift
//  FitStrap
//
//  Created by 1101249 on 1/24/23.
//

import Foundation

protocol ExerciseServiceable {
    func getAllExercises() async -> Result<[Exercise], RequestError>
}

struct ExerciseService: ExerciseServiceable, HTTPClient {
    func getAllExercises() async -> Result<[Exercise], RequestError> {
        return await request(endPoint: ExerciseEndpoint.all, responseModel: [Exercise].self)
    }
}
