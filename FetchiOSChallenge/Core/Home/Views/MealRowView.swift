//
//  MealRowView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct MealRowView: View {
    
    let meal: MealModel
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealRowView(meal: dev.meal)
                .previewLayout(.sizeThatFits)
        }
    }
}

extension MealRowView {
    private var leftColumn: some View {
        HStack(spacing: 0.0) {
            MealImageView(meal: meal)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                    
            Text(meal.strMeal)
                .font(.headline)
                .fontWeight(.regular)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
        .padding(5)
        .padding(.leading, 10)
    }
}