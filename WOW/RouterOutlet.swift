//
//  RouterOutlet.swift
//  WOW
//
//  Created by Caleb Wilson on 21/09/2022.
//

import SwiftUI

//enum Route : Hashable {
//    case Movie(String)
//    case Wow(Wow)
//}

struct RouterOutlet<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationDestination(for: String.self, destination: MovieView.init)
                .navigationDestination(for: Wow.self, destination: WowDetailView.init)
        }
    }
}
