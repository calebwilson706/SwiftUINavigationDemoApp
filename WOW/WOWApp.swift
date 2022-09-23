//
//  WOWApp.swift
//  WOW
//
//  Created by Caleb Wilson on 20/09/2022.
//

import SwiftUI

@main
struct WOWApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesListView()
                    .tabItem {
                        Label("Movies", systemImage: "film.stack.fill")
                    }

                DirectorsListView()
                    .tabItem {
                        Label("Directors", systemImage: "megaphone.fill")
                    }
            }
        }
    }
}
