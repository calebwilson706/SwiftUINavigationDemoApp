//
//  MovieView.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import SwiftUI

struct MovieView: View {
    let movie: String

    var body: some View {
        List(["1", "2"], id: \.self, rowContent: Text.init)
            .navigationTitle("Wows in \(movie)")
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: "Kung Fu Panda")
    }
}
