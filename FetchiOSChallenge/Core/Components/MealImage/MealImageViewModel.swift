//
//  MealImageViewModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import SwiftUI
import Combine

class MealImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil // this is set when the addSubscriber function in this class runs fully.
    @Published var isLoading: Bool = false // this is set when the addSubscriber function in this class is run.
    
    private let meal: MealModel // this meal variable is set when we create a instance of this class in the MealImageView.
    private let dataService: MealImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(meal: MealModel) {
        self.meal = meal // this meal variable (as said above) is set when we create a instance of this class in the MealImageView.
        self.dataService = MealImageService(meal: meal) // once we have meal, we can create an instance of MealImageService class. Once we create the instance and the init of MealImageService is called then we get the image in that class either from file manager or we download it if not available.
        self.addSubscribers()
        self.isLoading = true // initially set to true.
    }
    
    private func addSubscribers(){
        dataService.$image // $image is a publisher present in MealImageService class. so whenever this image property get a new image then this emits a new value.
            
        // sink operator attaches a subscriber to the above publisher. So this sink has 2 parts - 1) handeling completion and 2) receiving actual value.
        // 1) So when it is completed (either .failure or .finished) we set the isLoading to false because either we got the image or we did not. In case we got it we will display it in the MealImageView. If we did not we will display the question mark as we can see in MealImageView if else statements.
        //2) When we receive the actual value i.e the returnedImage in the form of UIImage then we set it to image variable (published) in this class. So now MealImageView will get this update since this image variable is a published variable.
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}

