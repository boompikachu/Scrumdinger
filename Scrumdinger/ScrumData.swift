//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Patthanat Thanintantrakun on 19/12/2563 BE.
//

import Foundation

class ScrumData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Cannot find docs directory")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
    
    @Published var scrums: [DailyScrum] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
                #endif
                return
            }
            guard let dailyscrum = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
                fatalError("Cannot decode saved scrum data")
            }
            DispatchQueue.main.async {
                self?.scrums = dailyscrum
            }
        }
    }
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrums = self?.scrums else {
                fatalError("self out of scope")
            }
            guard let data = try? JSONEncoder().encode(scrums) else {
                fatalError("Error encoding data")
            }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
