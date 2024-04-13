//
//  Song.swift
//  PlaylistManager
//
//  Created by Adit Chakraborty on 02/04/2024.
//

import Foundation
import AVFoundation

class Song: Identifiable {
    let id: UUID
    var name: String
    var author: String
    var lengthInMins: Int
    var fileURL: URL?
    var songPlayer: AVAudioPlayer?
    
    private func createAudioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let url = fileURL else {
                return
            }
            
            songPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("something went wrong")
        }
    }
    
    init(id: UUID = UUID(), name: String, author: String, lengthInMins: Int, fileURL: URL? = nil) {
        self.id = id
        self.name = name
        self.author = author
        self.lengthInMins = lengthInMins
        self.fileURL = fileURL
        createAudioPlayer()
    }
    
    public func play() {
        songPlayer?.play()
    }
    
    public func stop() {
        songPlayer?.stop()
    }
    
    static var testSongs: [Song] = [
        Song(name: "Master of Puppets", author: "Metallica", lengthInMins: 3),
        Song(name: "Scotty Doesn't Know", author: "Lustra", lengthInMins: 3),
        Song(name: "Ain't No Sunshine", author: "Bill Withers", lengthInMins: 2),
        Song(name: "Creep", author: "Radiohead", lengthInMins: 3),
        Song(name: "Supermassive Black Hole", author: "Muse", lengthInMins: 3),
        Song(name: "Portrait of a Blank Slate", author: "Lovejoy", lengthInMins: 3),
        Song(name: "Under Pressure", author: "Queen", lengthInMins: 3),
        Song(name: "Arabella", author: "Arctic Monkeys", lengthInMins: 2),
        Song(name: "I Don't Wanna Be Me", author: "Type O Negative", lengthInMins: 3),
        Song(name: "Still D.R.E", author: "Dr Dre", lengthInMins: 3),
        Song(name: "Lace It Up", author: "Juice WRLD", lengthInMins: 3),
        Song(name: "Still D.R.E", author: "Dr Dre", lengthInMins: 3),
        Song(name: "Beautiful Things", author: "Benson Boone", lengthInMins: 3),
    ]
}
