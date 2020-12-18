//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Patthanat Thanintantrakun on 18/12/20.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
            NavigationView() {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
