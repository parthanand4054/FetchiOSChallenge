//
//  HomeViewModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allMeals: [MealModel] = []
    @Published var searchText: String = ""
    
    private let dataService = MealDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // updates allMeals
        $searchText
            .combineLatest(dataService.$allMeals)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterMeals)
            .sink { [weak self] (returnedMeals) in
                self?.allMeals = returnedMeals
            }
            .store(in: &cancellables)
    }
    
    private func filterMeals(text: String, meals: [MealModel]) -> [MealModel] {
        guard !text.isEmpty else {
            return meals
        }
        
        let lowercasedText = text.lowercased()
        
        return meals.filter { (meal) -> Bool in
            return meal.strMeal.lowercased().contains(lowercasedText)
        }
    }
    
}
