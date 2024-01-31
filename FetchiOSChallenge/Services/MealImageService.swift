//
//  MealImageService.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import SwiftUI
import Combine

class MealImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let meal: MealModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "meal_images"
    private let imageName: String
    
    init(meal: MealModel) {
        self.meal = meal
        self.imageName = meal.id
        getMealImage()
    }
    
    private func getMealImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from file manager!")
        } else {
            downloadMealImage()
            print("Downloading image now")
        }
    }
    
    private func downloadMealImage(){
        guard let url = URL(string: meal.strMealThumb)
        else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}

