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
                
                for song in json {
                    let currSong = Song(
                        name: song["song_name"].stringValue,
                        artist: song["artist_name"].stringValue,
                        album: song["album_name"].stringValue,
                        imageUrl: song["album_image"].stringValue,
                        audioUrl: song["preview_url"].stringValue
                    )
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
