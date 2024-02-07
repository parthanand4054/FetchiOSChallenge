//
//  NetworkingManager.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad responsor from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    // This function is used to fetch the data from a given url.
    // Returns a publisher which has data or any errors that might have occured.
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
         return URLSession.shared.dataTaskPublisher(for: url) // creates a dataTaskPublisher, starts a network request to the url.
            .subscribe(on: DispatchQueue.global(qos: .default)) // the network request is to be performed on background thread and not main thread.
            .tryMap({try handleURLResponse(output: $0, url: url)}) // trymap inspects the received "response" from the "output" using the handleURLResponse function that I have created below. If the response is valid i.e an HTTPURLResponse and also if the status code is valid i.e between 200 and 300. If both conditions are fine then it return the "data" part of the "output"
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    }
    
    // used by tryMap to handle the response & check if the response is valid i.e an HTTPURLResponse and also if the status code is valid i.e between 200 and 300. If both conditions are fine then it return the "data" part of the "output"
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    // used in .sink to handle the completion.
    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, [MealModel], JSONDecoder>.Failure>) {
        
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

}

