//
//  DirectorView.swift
//  WOW
//
//  Created by Caleb Wilson on 22/09/2022.
//

import SwiftUI

struct DirectorView: View {
    private let director: String
    @State private var wows: WowApiResponse
    
    init(director: String) {
        self.director = director
        self.wows = []
    }

    var body: some View {
        List(wows, id: \.self) {wow in
            NavigationLink("\(wow.fullLine)", value: Route.Wow(wow))
        }
        .navigationTitle(director)
        .onAppear {
            Task {
                self.wows = await OwenWilsonService.getWowsInMoviesBy(director: director)
            }
        }
    }
}

struct DirectorView_Previews: PreviewProvider {
    static var previews: some View {
        DirectorView(director: "Megamind")
    }
}
