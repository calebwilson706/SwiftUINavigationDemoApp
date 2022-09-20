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
        }.onAppear {
            Task {
                await updateMovieList()
            }
        }
    }
    
    @Sendable func updateMovieList() async {
        do {
            movies = try await OwenWilsonService.getMovies()
        } catch {
            // handle error
            movies = []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
