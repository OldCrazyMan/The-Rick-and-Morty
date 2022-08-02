//
//  NetworkDataFetch.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit
import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
    }
    
    enum endpoints: String {
        case character
        case location
        case episode
        case avatar
    }
    
    private init() {}
    
    func fetchCharacters(page: Int, completed: @escaping (Swift.Result<Character, Error>) -> Void) {
        
        let endpoint = Constants.baseURL + "/character/?page=\(page)"
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completed(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let characters = try decoder.decode(Character.self, from: data)
                    completed(.success(characters))
                } catch { return }
            }
        }
        task.resume()
    }
    
    func getLocationsData(page: Int, completion: @escaping (Swift.Result<PagedLocation, Error>) -> Void) {
    
        guard let url = URL(string: Constants.baseURL + endpoints.location.rawValue + "/?page=\(String(page))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let locations = try JSONDecoder().decode(PagedLocation.self, from: data)
                
                completion(.success(locations))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    public func getEpisodesData(page: Int, completion: @escaping (Swift.Result<PagedEpisode, Error>) -> Void) {
        
        
        guard let url = URL(string: Constants.baseURL + endpoints.episode.rawValue + "/?page=\(String(page))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let episodes = try JSONDecoder().decode(PagedEpisode.self, from: data)
                
                completion(.success(episodes))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    func fetchCharacterCount(completed: @escaping (Swift.Result<Character, Error>) -> Void) {
        
        let endpoint = Constants.baseURL + "/character)"
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterCount = try decoder.decode(Character.self, from: data)
                completed(.success(characterCount))
            } catch { return }
        }
        task.resume()
    }
}

