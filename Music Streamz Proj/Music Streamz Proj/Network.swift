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
    

    static func shuffleSongs(arr: [Song]) -> [Song] {
        var arr = Array(arr)
        var i = arr.count - 1
        
        while i >= 1 {
            let j = Int(arc4random_uniform(UInt32(i)) + 1)
            arr.swapAt(i, j)
            i -= 1
        }
        
        return arr
    }
    
    static func getRecommendations(pickedSongs: [Song], limit: Int, _ completion: @escaping ([Song]) -> Void) {
        let numToDrop = pickedSongs.count <= 5 ? 0 : pickedSongs.count - 5 // Spotify only lets you seed 5 songs
        let limitedPickedSongs = shuffleSongs(arr: pickedSongs).dropLast(numToDrop)
        
        var modPickedSongs: [[String: String]] = []
        for currSong in limitedPickedSongs {
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
