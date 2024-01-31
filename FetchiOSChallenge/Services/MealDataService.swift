//
//  MealDataService.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import Combine

class MealDataService {
    
    @Published var allMeals: [MealModel] = []
    
    var mealSubscription: AnyCancellable?
    
    init() {
        getMeals()
    }
    
    private func getMeals() {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        else {return}
        
        mealSubscription = NetworkingManager.download(url: url)
            .decode(type: MealResponse.self, decoder: JSONDecoder()) // Decode to MealResponse instead of [MealModel]
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedResponse) in
                self?.allMeals = returnedResponse.meals // Access the meals array from the MealResponse
                self?.mealSubscription?.cancel()
            })
    }
}
