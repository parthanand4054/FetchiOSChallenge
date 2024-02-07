//
//  HomeViewModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

// This view model manages all the data for the HomeView.
// first all the properties are initialized.
// then init is called.

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allMeals: [MealModel] = [] // this array is set/updated by the addSubscribers function below based on what the user searches in search bar.
    @Published var searchText: String = "" // this variable is binded or connected to the searchText binding variable in SearchBarView. Check the HomeView to see how it is binded. And what this does is, whenever user searches a text in the search bar then this variable gets that value.
    
    private let dataService = MealDataService() // we needed to initialize this since we need a reference to MealDataService to get the allMeals array that we get from the API call. Also, its initialization does the network call and fetches the data from API.
    
    private var cancellables = Set<AnyCancellable>() // 1) By storing the subscription in cancellables, you ensure that the subscription is retained in memory. This prevents the subscription from being deallocated prematurely, which would stop the delivery of updates from the publisher. 2)  When your view model (or whatever object owns the cancellables set) is deinitialized, all subscriptions stored in cancellables are automatically canceled. This is crucial for avoiding memory leaks and ensuring that your app doesn't continue to do unnecessary work, such as listening for updates that are no longer needed.
    
    init() {
        addSubscribers()
    }
    
    // On a very high level this function sets the value of allMeals array above based on what the user searches in the search bar. So if a user starts to type something like choco.. then this allMeals will have the list of all the meals that contains choco.
    func addSubscribers() {
        $searchText // This is a publisher for searchText property & it emits a new value everytime user changes the search text.
            .combineLatest(dataService.$allMeals) // This operator combines the latest value from the $searchText publisher with the latest list of "allMeals" from MealDataService class. That allMeals is basically all the meals from the API. Also, whenever either searchText changes or allMeals from the MealDataService changes then this operator emits a tuple containing both the current searchText and current list of meals i.e allMeals.
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // This operator waits for 0.5 seconds after the last change to the search text before emitting the latest values. This is used to reduce the number of times the list is filtered which can be computationally expensive specially when the user is typing quickly.
        
            .map(filterMeals) // This map operator applies the 'filterMeals' function below to each each tuple of search text and meal list emitted by the previous step. The filterMeals function basically returns a new list of meals that matches the search text.
            .sink { [weak self] (returnedMeals) in // this finally provides the filtered meals list which is assigned to allMeals array declared above. Since this allMeals is published, it also updates the UI in the HomeView when it is accessed inside the for loop in the allMealsList in the extension. So home view will show the filtered meals when the user types some text in search bar. Also [weak self] is used to avoid strong reference so that the class can be easily deinitialized when required by the system.
                self?.allMeals = returnedMeals
            }
            .store(in: &cancellables)
    }
    
    // The filterMeals function basically returns a new list of meals that matches the search text.
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
