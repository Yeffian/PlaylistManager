//
//  Playlist.swift
//  PlaylistManager
//
//  Created by Adit Chakraborty on 02/04/2024.
//

import SwiftUI

struct Playlist: Identifiable {
    let id: UUID
    var name: String
    var songs: [Song]
    
    var listeningTimeInMinutes: Int {
        var result = 0
        
        for song in songs {
            result += song.lengthInMins
        }
        
        return result
    }
    
    var listeningTimeInHours: Int {
        Int(listeningTimeInMinutes / 60)
    }
    
    var formattedListeningTime: String {
        if listeningTimeInMinutes > 60 {
            return String(listeningTimeInHours) + (listeningTimeInHours == 1 ? " hr" : " hrs")
        } else {
            return String(listeningTimeInMinutes) + " mins"
        }
    }
    
    init(id: UUID = UUID(), name: String, songs: [Song]) {
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    static var testingData: [Playlist] = [
        Playlist(name: "Study", songs: [Song.testSongs[0], Song.testSongs[1], Song.testSongs[2], Song.testSongs[8]]),
        Playlist(name: "Workout", songs: [Song.testSongs[3], Song.testSongs[4], Song.testSongs[5], Song.testSongs[10]]),
        Playlist(name: "Reading", songs: [Song.testSongs[6], Song.testSongs[7]]),
        Playlist(name: "Car", songs: [Song.testSongs[9], Song.testSongs[10], Song.testSongs[11], Song.testSongs[5], Song.testSongs[2]])
    ]
}
