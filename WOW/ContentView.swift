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
        RouterOutlet {
            List(movies, id: \.self) { movie in
                NavigationLink(movie, value: movie)
            }
            .navigationTitle("Owen Wilson Movies")
            .refreshable(action: updateMovieList)
            .onAppear {
                Task {
                    await updateMovieList()
                }
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
