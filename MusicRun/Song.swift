//
//  Song.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit

class Song{
    
    var title: String
    var artist: String
    var score: Int
    var playableSong: String
    var songArray: Array<Int>
    var cover: UIImage
    
    init(title: String, artist: String, playableSong: String, songArray: Array<Int>, cover: UIImage){
        
        self.title = title
        self.artist = artist
        self.score = 0
        self.playableSong = playableSong
        self.songArray = songArray
        self.cover = cover
    }
    
}
