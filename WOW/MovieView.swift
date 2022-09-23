//
//  MovieView.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import SwiftUI

struct MovieView: View {
    private let movie: String
    @State private var wows: WowApiResponse
    
    init(movie: String) {
        self.movie = movie
        self.wows = []
    }

    var body: some View {
        List(wows, id: \.self) {wow in
            NavigationLink("\(wow.currentWowInMovie)", value: Route.Wow(wow))
        }
        .navigationTitle("Wows in \(movie)")
        .onAppear {
            Task {
                self.wows = await OwenWilsonService.getWowsIn(movie: movie)
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieView(movie: "Kung Fu Panda")
        }
    }
}
