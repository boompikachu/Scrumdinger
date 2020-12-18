//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Patthanat Thanintantrakun on 18/12/20.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
        }
        .navigationTitle("Daily Scrum")
        .navigationBarItems(trailing: Button(action: {}, label: {
            Image(systemName: "plus")
        }))
    }
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
            guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
                fatalError("Can't find scrum in array")
            }
        return $scrums[scrumIndex]
        }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView() {
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
    }
}
