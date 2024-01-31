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
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let meal: MealModel
    private let dataService: MealImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(meal: MealModel) {
        self.meal = meal
        self.dataService = MealImageService(meal: meal)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}

