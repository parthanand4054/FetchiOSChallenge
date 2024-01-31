//
//  MealDetailDataService.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import Combine

class MealDetailDataService {
    
    @Published var mealDetail: DetailedMeal? = nil
    
    var mealDetailSubscription: AnyCancellable?
    let meal: MealModel
    
    init(meal: MealModel) {
        self.meal = meal
        getMealDetails()
    }
    
    private func getMealDetails() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.id)")
        else {return}
        
        mealDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: DetailedMealResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedMealDetails) in
                self?.mealDetail = returnedMealDetails.meals.first
                self?.mealDetailSubscription?.cancel()
            })
    }
}

