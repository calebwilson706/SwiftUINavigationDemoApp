//
//  ContentView.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State var movies: MoviesApiResponse = []
    
    var body: some View {
        NavigationStack {
            List(movies, id: \.self) { movie in
                NavigationLink(movie, value: movie)
            }.refreshable(action: updateMovieList)
             .navigationTitle("Owen Wilson Movies")
             .navigationDestination(for: String.self, destination: MovieView.init)
             .navigationDestination(for: Wow.self, destination: WowDetailView.init)
        }.onAppear {
            Task {
                await updateMovieList()
            }
        }
    }
    
    @Sendable func updateMovieList() async {
        movies = await OwenWilsonService.getMovies()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
