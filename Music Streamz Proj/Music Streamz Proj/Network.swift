//
//  Network.swift
//  Music Streamz Proj
//
//  Created by Tyler Ishikawa on 5/4/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Network {
    
    private static let endpoint = "https://musicstreamz.tyleri.me"
    
    static func searchSongs(query: String, page: Int = 1, _ completion: @escaping ([Song]) -> Void) {
        let parameters: Parameters = [
            "q": query.replacingOccurrences(of: " ", with: "+"),
            "type": "song",
            "page": page
        ]
        
        Alamofire.request("\(endpoint)/search", parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let json = JSON(json).arrayValue
                var listSongs: [Song] = []
                
                for jsonSong in json {
                    let currSong = Song(json: jsonSong)
                    listSongs.append(currSong)
                }
                completion(listSongs)
                
            case .failure(let error):
                print("Error: \(error)")
                completion([])
            }
        }
    }
    
    static func getRecommendations(pickedSongs: [Song], limit: Int, _ completion: @escaping ([Song]) -> Void) {
        var modPickedSongs: [[String: String]] = []
        for currSong in pickedSongs {
            modPickedSongs.append([
                "song_name": currSong.name,
                "artist_name": currSong.artist
            ])
        }
        
        if modPickedSongs.isEmpty {
            modPickedSongs = [[
                "song_name": "Closer",
                "artist_name": "The Chainsmokers"
            ]]
        }
        
        let parameters: Parameters = [
            "picked_songs": modPickedSongs,
            "limit": limit
        ]
        
        Alamofire.request(
            "\(endpoint)/recommendation",
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let json = JSON(json).arrayValue
                var listSongs: [Song] = []
                
                for jsonSong in json {
                    let currSong = Song(json: jsonSong)
                    listSongs.append(currSong)
                }
                completion(listSongs)
                
            case .failure(let error):
                print("Error: \(error)")
                completion([])
            }
        }
    }
}
