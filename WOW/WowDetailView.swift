//
//  WowDetailView.swift
//  WOW
//
//  Created by Caleb Wilson on 21/09/2022.
//

import SwiftUI

struct WowDetailView: View {
    let wow: Wow

    var body: some View {
        VStack {
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text(wow.fullLine)
                        .font(.headline)
                        .bold()
                    Text("- \(wow.character)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding(.top)
            Spacer()
        }
        .padding()
        .navigationTitle("\(wow.movie) - \(wow.currentWowInMovie)/\(wow.totalWowsInMovie)")
    }
}

struct WowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WowDetailView(wow:
                Wow(
                    movie: "Kung fu panda",
                    year: 2008,
                    releaseDate: "2008-10-10",
                    director: "",
                    character: "Po",
                    movieDuration: "5",
                    timestamp: "5",
                    fullLine: "Wowwww",
                    currentWowInMovie: 1,
                    totalWowsInMovie: 1,
                    poster: "",
                    video: Video(the1080P: "", the720P: "", the480P: "", the360P: ""),
                    audio: "")
                )
        }
    }
}
