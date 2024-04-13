//
//  PlaylistGroupView.swift
//  PlaylistManager
//
//  Created by Adit Chakraborty on 02/04/2024.
//

import SwiftUI
import AVFoundation

struct PlaylistGroupView: View {
    @Binding var playlist: Playlist
    @State private var addingSongToPlaylist = false
    @State private var isPickingFile = false
    
    @State private var newSong = Song(name: "", author: "" , lengthInMins: 1)
    @State private var player: AVAudioPlayer?
    
    @State private var stoppedIcon = false
    
    var playButtonTint: Color {
        if stoppedIcon {
            return .red
        } else {
            return .green
        }
    }
    
    var playButtonIcon: Image {
        if stoppedIcon {
            return Image(systemName: "stop.circle")
        } else {
            return Image(systemName: "play")
        }
    }
    
    var addingSongView: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form {
                    Section("About") {
                        TextField("Song name", text: $newSong.name)
                        TextField("Song author", text: $newSong.author)
                        HStack {
                            Text("Song length (in mins)")
                            Spacer()
                            Text("\(newSong.lengthInMins)")
                        }
                    }
                    
                    Section("Music") {
                        HStack {
                            Stepper("How long is the song?", value: $newSong.lengthInMins, in: 1...20)
                        }
                        Button {
                            isPickingFile.toggle()
                        } label: {
                            Text("Pick")
                        }
                    }
                    
                    Button(action: {
                        addingSongToPlaylist.toggle()
                        withAnimation {
                            playlist.songs.append(newSong)
                            newSong = Song(name: "", author: "", lengthInMins: 0)
                        }
                    }) {
                        Text("Add Song to \(playlist.name)")
                    }
                }
            }
            .navigationTitle("Adding song to \(playlist.name)")
            .fileImporter(isPresented: $isPickingFile, allowedContentTypes: [.mp3], onCompletion: { results in
                switch results {
                case .success(let Fileurl):
                    newSong.fileURL = Fileurl
                    print(Fileurl)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
     
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if (playlist.songs.isEmpty) {
                    Text("No added songs.")
                }
                List {
                    ForEach(playlist.songs) { song in
                        VStack(alignment: .leading) {
                            Text(song.name)
                            HStack {
                                Label(song.author, systemImage: "person")
                                Spacer()
                                Label("\(song.lengthInMins) mins", systemImage: "clock")
                                Spacer()
                                Button {
                                    stoppedIcon.toggle()
                                    if let player = player, player.isPlaying {
                                        player.stop()
                                    } else {
                                        do {
                                            try AVAudioSession.sharedInstance().setMode(.default)
                                            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                                                                        
                                            guard let songUrl = song.fileURL else {
                                                return
                                            }
                                                                                
                                            player = try AVAudioPlayer(contentsOf: songUrl)
                                            guard let player = player else {
                                                return
                                            }
                                                                            
                                            player.play()
                                        } catch {
                                            print("something went wrong")
                                        }
                                    }
                                } label: {
//                                    if song.fileURL == player?.url {
//                                        if let player = player, player.isPlaying {
//                                            playButtonIcon
//                                                .tint(playButtonTint)
//                                        }
//                                    }
//                                    else {
//                                        Image(systemName: "play")
//                                    }
                                    if song.fileURL == player?.url {
                                        playButtonIcon
                                            .tint(playButtonTint)
                                    } else {
                                        Image(systemName: "play")
                                            .tint(.green)
                                    }
                                    
//                                    for s in playlist.songs {
//                                        if s.fileURL == player?.url {
//                                            Image(playButtonIcon)
//                                                .tint(playButtonTint)
//                                        }
//                                        
//                                        Image(systemName: "play")
//                                            .tint(.green)
//                                    }
                                    
                                }
                            }
                            .font(.caption)
                            
                        }
                    }
                    .onDelete(perform: { indexSet in
                        playlist.songs.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle(playlist.name)
                .toolbar {
                    Button(action: {
                        addingSongToPlaylist.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $addingSongToPlaylist, content: {
            addingSongView
        })
    }
}

#Preview {
    PlaylistGroupView(playlist: .constant(Playlist.testingData[1]))
}
