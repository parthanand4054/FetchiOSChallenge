//
//  MealDataService.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

// CLASS SUMMARY:
// As soon as the app starts we create an object of HomeViewModel. Now, inside HomeViewModel it creates a object for this class i.e MealDataService. So as soon as the object of this class gets created, the init is called and so getMeals is called which basically at a high level gets the list of all the meals from the internet and stores it in the "allMeals" array where each meal is of type "MealModel".

import Foundation
import Combine

class MealDataService {
    
    @Published var allMeals: [MealModel] = [] // allMeals will store all the meals that comes from the API.
    
    var mealSubscription: AnyCancellable?
    
    init() {
        getMeals()
    }
    
    private func getMeals() {
        
        // API url from which the meals data is downloaded.
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        else {return}
        
        mealSubscription = NetworkingManager.download(url: url) // Downloads all the meals data using the download function that I have created in the NetworkingManager class. The data is in JSON format. 
            .decode(type: MealResponse.self, decoder: JSONDecoder()) // Since the data is in JSON format it needs to be decoded in the format of the model that we have created.
            
            // sink gets the completion (weather success or failure) & the received value (in this case our data in the decoded format). The self below creates a strong reference to the class. If for some reason we need to deallocate this class, the system would not be able to do so because of strong reference. so we add weak self keyword
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedResponse) in
                self?.allMeals = returnedResponse.meals //Access meals array from the MealResponse and assign it to "allMeals" array.
                self?.mealSubscription?.cancel() // since its just 1 get request and data wont be coming again and again so once it comes we can just cancel it. We dont have to keep listening. 
            })
    }
}
