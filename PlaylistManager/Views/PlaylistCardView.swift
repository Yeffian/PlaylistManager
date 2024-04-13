//
//  PlaylistGroupView.swift
//  PlaylistManager
//
//  Created by Adit Chakraborty on 02/04/2024.
//

import SwiftUI

struct PlaylistCardView: View {
    let playlist: Playlist
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(playlist.name)
            HStack {
                Label("\(playlist.songs.count)", systemImage: "music.note")
                Spacer()
                Label(playlist.formattedListeningTime, systemImage: "clock")
            }
            .font(.caption)
        }
    }
}

#Preview {
    PlaylistCardView(playlist: Playlist.testingData[0])
}
