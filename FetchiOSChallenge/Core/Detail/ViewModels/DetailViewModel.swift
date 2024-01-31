//
//  DetailViewModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var mealInstruction: String? = nil
    @Published var mealIngredients: [String] = []
    @Published var mealMeasures: [String] = []
    
    let meal: MealModel
    private let mealDetailService: MealDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(meal: MealModel) {
        self.meal = meal
        self.mealDetailService = MealDetailDataService(meal: meal)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        mealDetailService.$mealDetail
            .sink { [weak self] (returnedMealDetails) in
                self?.mealInstruction = returnedMealDetails?.strInstructions
                self?.mealIngredients = returnedMealDetails?.ingredients ?? []
                self?.mealMeasures = returnedMealDetails?.measures ?? []
                print("Ingredients: \(self?.mealIngredients ?? [])")
            }
            .store(in: &cancellables)
    }
    
}
