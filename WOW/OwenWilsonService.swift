//
//  OwenWilsonService.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import Foundation

struct Wow: Codable, Identifiable {
    var id: String {
        "\(movie)\(timestamp)"
    }
    
    let movie: String
    let year: Int
    let releaseDate: String
    let director: String
    let character: String
    let movieDuration: String
    let timestamp: String
    let fullLine: String
    let currentWowInMovie: Int
    let totalWowsInMovie: Int
    let poster: String
    let video: Video
    let audio: String
}


struct Video: Codable {
    let the1080P, the720P, the480P, the360P: String

    enum CodingKeys: String, CodingKey {
        case the1080P = "1080p"
        case the720P = "720p"
        case the480P = "480p"
        case the360P = "360p"
    }
}

typealias WowApiResponse = [Wow]
typealias MoviesApiResponse = [String]

class OwenWilsonService {
    static let baseUrl = "https://owen-wilson-wow-api.herokuapp.com/wows"
    
    static func getMovies() async throws -> MoviesApiResponse {
        guard let url = URL(string: "\(OwenWilsonService.baseUrl)/movies") else {
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(MoviesApiResponse.self, from: data)
    }
}
