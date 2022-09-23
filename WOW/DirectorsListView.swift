//
//  DirectorsListView.swift
//  WOW
//
//  Created by Caleb Wilson on 22/09/2022.
//

import SwiftUI

struct DirectorsListView: View {
    @State private var directors: DirectorsApiResponse = []
    
    var body: some View {
        RouterOutlet {
            List(directors, id: \.self) { director in
                NavigationLink(director, value: Route.Director(director))
            }
            .navigationTitle("Owen Wilson's Directors")
            .refreshable(action: fetchDirectors)
            .onAppear {
                Task {
                    await fetchDirectors()
                }
            }
        }
    }
    
    @Sendable func fetchDirectors() async {
        directors = await OwenWilsonService.getDirectors()
    }
}

struct DirectorsListView_Previews: PreviewProvider {
    static var previews: some View {
        DirectorsListView()
    }
}
