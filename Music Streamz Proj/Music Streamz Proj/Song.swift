//
//  Song.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import Foundation

class Song {
    
    var name: String
    var artist: String
    var album: String
    var imageUrl: String
    var audioUrl: String
    
    init(name: String, artist: String, album: String, imageUrl: String, audioUrl: String) {
        self.name = name
        self.artist = artist
        self.album = album
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
    }
}

