//
//  Song.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class Song: NSObject {
    
    var name: String
    var artist: String
    var album: String
    var imageUrl: String
    
    override var description: String {
        return "Song(\(name), \(artist), \(album))"
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased() && lhs.artist.lowercased() == rhs.artist.lowercased()
    }
    
    static func !=(lhs:Song, rhs: Song) -> Bool {
        return !(lhs == rhs)
    }
    
    init(name: String, artist: String, album: String, imageUrl: String) {
        self.name = name
        self.artist = artist
        self.album = album
        self.imageUrl = imageUrl
    }
    
    init(json: JSON) {
        self.name = json["song_name"].stringValue
        self.artist = json["artist_name"].stringValue
        self.album = json["album_name"].stringValue
        self.imageUrl = json["album_image"].stringValue
    }
}

