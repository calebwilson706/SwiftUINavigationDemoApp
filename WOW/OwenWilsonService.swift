//
//  OwenWilsonService.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import Foundation

struct Wow: Codable, Identifiable, Hashable {
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
    
    enum CodingKeys: String, CodingKey {
        case movie = "movie"
        case year = "year"
        case releaseDate = "release_date"
        case director = "director"
        case character = "character"
        case movieDuration = "movie_duration"
        case timestamp = "timestamp"
        case fullLine = "full_line"
        case currentWowInMovie = "current_wow_in_movie"
        case totalWowsInMovie = "total_wows_in_movie"
        case poster = "poster"
        case video = "video"
        case audio = "audio"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String {
        "\(movie)\(timestamp)"
    }
    
    static func == (lhs: Wow, rhs: Wow) -> Bool {
        return lhs.id == rhs.id
    }
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
typealias DirectorsApiResponse = [String]

enum WowApiErrors: Error {
    case invalidUrl
}

class OwenWilsonService {
    static private let baseUrl = "https://owen-wilson-wow-api.herokuapp.com/wows"
    
    static func getMovies() async -> MoviesApiResponse {
        let data: MoviesApiResponse? = try? await fetchFromApiAt(endpoint: "/movies")
        
        return data ?? []
    }
    
    static func getDirectors() async -> DirectorsApiResponse {
        let data: MoviesApiResponse? = try? await fetchFromApiAt(endpoint: "/directors")
        
        return data ?? []
    }
    
    static func getWowsIn(movie: String) async -> WowApiResponse {
        let urlSafeQuery = makeQueryUrlSafe("results=1000&movie=\(movie)&sort=number_current_wow")
        let data: WowApiResponse? = try? await fetchFromApiAt(endpoint: "/random?\(urlSafeQuery)")
        
        return data ?? []
    }
    
    static func getWowsInMoviesBy(director: String) async -> WowApiResponse {
        let urlSafeQuery = makeQueryUrlSafe("results=1000&director=\(director)")
        let data: WowApiResponse? = try? await fetchFromApiAt(endpoint: "/random?\(urlSafeQuery)")
        
        return data ?? []
    }
    
    private static func fetchFromApiAt<ResponseType: Decodable>(endpoint: String) async throws -> ResponseType {
        guard let url = URL(string: "\(OwenWilsonService.baseUrl)\(endpoint)") else {
            throw WowApiErrors.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    private static func makeQueryUrlSafe(_ query: String) -> String {
        query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
