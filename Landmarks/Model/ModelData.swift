//
//  ModelData.swift
//  Landmarks
//
//  Created by João Mauricio UWE ID 18030724 on 26/02/2022.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks : [Landmark] = loadJSON()
    
    func save() throws {
        let localDocumentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let localJsonURL = localDocumentsURL.appendingPathComponent("landmarkData").appendingPathExtension(for: .json)
        
        let data = try! JSONEncoder().encode(landmarks)
        try! data.write(to: localJsonURL, options: .atomic)
    }
    
    var categories: [String : [Landmark]] {
        Dictionary(grouping: landmarks) {$0.category}
    }
    
    var featuredLandmarks: [Landmark] {
        landmarks.filter{$0.isFeatured}
    }
}

func loadJSON() -> [Landmark] {
    let localDocumentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let localJsonURL = localDocumentsURL.appendingPathComponent("landmarkData").appendingPathExtension(for: .json)
    
    if FileManager.default.isReadableFile(atPath: localJsonURL.path) { // if app already has a local JSON file (app has been opened before)
        
        let jsonData = try! Data(contentsOf: localJsonURL)
        let decodedData = try! JSONDecoder().decode([Landmark].self, from: jsonData)
        return decodedData
        
    } else { // else if app is opening for the first time and we only have the json file in the Bundle's resources
        
        let bundleURL = Bundle.main.url(forResource: "landmarkData.json", withExtension: nil)!
        try! FileManager.default.copyItem(at: bundleURL, to: localJsonURL) // copy JSON file from Bundle to a new local JSON file
        return load("landmarkData.json")
    }
}


func load<T: Decodable>(_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in the main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch  {
        fatalError("Couldn't load \(filename) from main bundle: \(error)")
    }
    
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \(error)")
    }
}
