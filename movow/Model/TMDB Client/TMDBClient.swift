//
//  TMDBClient.swift
//  MovoW
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation


class TMDBClient {
    
    // MARK: - api Key
    static let apiKey = "02ee5b78642badb15ef92ad1f54f11da"
    
    
    // MARK: - Endpoints
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getMedia(MediaType, Sorting)
        case getDetails(MediaType, Int)
        case getCredits(MediaType, Int)
        case search(MediaType, String)
        case posterImageURL(String)
        
        var stringValue: String {
            switch self {
            case .getMedia(let mediaType, let sorting):
                return Endpoints.base + "/\(mediaType)/\(sorting.rawValue)" + Endpoints.apiKeyParam
            case .getDetails(let mediaType, let id):
                return Endpoints.base + "/\(mediaType)/\(id)" + Endpoints.apiKeyParam
            case .getCredits(let mediaType, let id):
                return Endpoints.base + "/\(mediaType)/\(id)/credits" + Endpoints.apiKeyParam
            case .search(let mediaType, let query):
                return Endpoints.base + "/search/\(mediaType)" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            case .posterImageURL(let posterPath):
                return "https://image.tmdb.org/t/p/w500" + posterPath
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    
    
    // MARK: - Http methods
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(responseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errrorResponse = try decoder.decode(TMDBResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errrorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    
    // MARK: - Request Functions
    
    class func getMedia(mediaType: MediaType, sorting: Sorting,completion: @escaping ([Media], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getMedia(mediaType, sorting).url, responseType: MediaResults.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getCredits(mediaType: MediaType, id: Int, completion: @escaping (Credits?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getCredits(mediaType, id).url, responseType: Credits.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func search(mediaType: MediaType, query: String, completion: @escaping ([Media], Error?) -> Void) -> URLSessionTask {
        taskForGETRequest(url: Endpoints.search(mediaType, query).url, responseType: MediaResults.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func downloadPosterImage(posterPath: String, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.posterImageURL(posterPath).url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
}

