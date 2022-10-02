//
//  KanyeQuoteViewModel.swift
//  KanyeRest
//
//  Created by Emirates on 09/08/2022.
//

import SwiftUI
import Combine

class KanyeQuoteViewModel : ObservableObject {
    
    @Published var quote = Quote(quote: "")
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getRandomQuote()
    }
    
    func getRandomQuote(){
        guard let url = URL(string: "https://api.kanye.rest/") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap({ (data, response) in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode > 199 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
                      
            })
            .decode(type: Quote.self, decoder: JSONDecoder())
            .sink { response in
                print("Response received Correctly: \(response)")
            } receiveValue: { [weak self] loadedQuote in
                self?.quote = loadedQuote
            }
            .store(in: &cancellables)

        
    }
}
