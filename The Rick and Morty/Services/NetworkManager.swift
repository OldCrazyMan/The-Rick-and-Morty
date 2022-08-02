//
//  NetworkManager.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 02.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
    }
    
    private init() {}
    
    //MARK: - getCaracters
    
    func getCaracters(page: Int, name: String?, status: String?, species: String?, gender: String?, completion: @escaping ([Character]) -> Void) {
        
        let path = "/character/?page=\(page)"
        let params: Parameters = [
            "name": name ?? "",
            "status": status ?? "",
            "species": species ?? "",
            "gender": gender ?? "",
        ]
        
        AF.request(Constants.baseURL + path, parameters: params).responseData { (response) in
            
            switch response.result {
            case .success:
                guard let data = response.value,
                      let characters = try? JSONDecoder().decode(CharacterList.self, from: data).results
                else { return }
                completion(characters)
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    public func getImage(fromUrl url: URLConvertible, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success:
                guard let imageData = response.value,
                      let image = UIImage(data: imageData, scale: 1.0)
                else { return }
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - getEpisode
    
    func getEpisode(url: String, completion: @escaping (PagedEpisode) -> Void) {
        
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value,
                      let episode = try? JSONDecoder().decode(PagedEpisode.self, from: data)
                else { return }
                completion(episode)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - getLocations
    
    func getLocations(page: Int, name: String?, type: String?, dimension: String?, completion: @escaping ([Location]) -> Void) {
        let path = "/location/?page=\(page)"
        
        let params: Parameters = [
            "name": name ?? "",
            "type": type ?? "",
            "dimension": dimension ?? ""
        ]
        
        AF.request(Constants.baseURL + path, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value,
                      let locations = try? JSONDecoder().decode(PagedLocation.self, from: data).results
                else { return }
                completion(locations)
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    //MARK: - getEpisodes
    
    func getEpisodes(page: Int, name: String?, completion: @escaping ([Episode]) -> Void) {
        let path = "/episode/?page=\(page)"
        
        let params: Parameters = [
            "name": name ?? ""
        ]
        
        AF.request(Constants.baseURL + path, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value,
                      let episodes = try? JSONDecoder().decode(PagedEpisode.self, from: data).results
                else { return }
                completion(episodes)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
