//
//  DetailView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var meal: MealModel?
    
    var body: some View {
        ZStack {
            if let meal = meal {
                DetailView(meal: meal)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    init(meal: MealModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(meal: meal))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                MealImageView(meal: vm.meal)
                    .cornerRadius(10)
                    .shadow(color: Color.theme.accent.opacity(0.25), radius: 5, x: 0, y: 2)
                    
                Text(vm.meal.strMeal)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                
                Text("Ingredients 🥗")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if vm.mealIngredients.isEmpty {
                    Text("Loading ingredients...")
                        .foregroundColor(Color.gray)
                } else {
                    ForEach(Array(zip(vm.mealIngredients, vm.mealMeasures)), id: \.0) { ingredient, measure in
                        HStack {
                            Text(ingredient)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(measure)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                                    
                Divider()
                
                Text("Instructions 📝")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    if let mealInstruction = vm.mealInstruction,
                       !mealInstruction.isEmpty {
                        Text(mealInstruction)
                           // .foregroundColor(Color.theme.secondaryText)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Meal Details")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(meal: dev.meal)
        }
    }
}
