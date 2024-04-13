//
//  ContentView.swift
//  PlaylistManager
//
//  Created by Adit Chakraborty on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var playlists: [Playlist]
    @State private var isAddingPlaylist = false
    @State private var newPlaylist = Playlist(name: "", songs: [])
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List($playlists) { $playlist in
                    NavigationLink {
                        PlaylistGroupView(playlist: $playlist)
                    } label: {
                        PlaylistCardView(playlist: playlist)
                    }
                }
            }
            .navigationTitle("Your playlists")
            .toolbar {
                Button(action: {
                    isAddingPlaylist.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingPlaylist, content: {
            NavigationStack {
                VStack {
                    Form {
                        TextField("Name of the playlist", text: $newPlaylist.name)
                        Button(action: {
                            playlists.append(newPlaylist)
                            newPlaylist.name = ""
                        }) {
                            Text("Add Playlist")
                        }
                    }
                    
                    
                }
                .navigationTitle("Create a new playlist")
            }
        })
    }
}

#Preview {
    ContentView(playlists: Playlist.testingData)
}

