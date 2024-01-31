//
//  MealImageView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct MealImageView: View {
    
    @StateObject var vm: MealImageViewModel
    
    init(meal: MealModel) {
        _vm = StateObject(wrappedValue: MealImageViewModel(meal: meal))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct MealImageView_Previews: PreviewProvider {
    static var previews: some View {
        MealImageView(meal: dev.meal)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
