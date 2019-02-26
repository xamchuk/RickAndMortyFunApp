//
//  NetworkService.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

class NetworkService {

    let urlString = "https://rickandmortyapi.com/api/character/"
    
    func loadCharcters(completion: @escaping([Character]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, respone, error) in
            guard let data = data else { return }

            do {
               let characters = try JSONDecoder().decode(Characters.self, from: data)
                DispatchQueue.main.async {
                    completion(characters.results)
                }
            } catch {
                DispatchQueue.main.async {
                    print("error: \(error)")
                    completion([])
                }
            }
        }.resume()
    }
}
