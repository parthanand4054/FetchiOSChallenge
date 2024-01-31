//
//  MealModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation

// URL: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert

// JSON RESPONSE FOR MEAL (FOLDED)
/*
{
  "meals": [
    {
      "strMeal": "Apam balik",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
      "idMeal": "53049"
    },
    {
      "strMeal": "Apple & Blackberry Crumble",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
      "idMeal": "52893"
    },
    {
      "strMeal": "Apple Frangipan Tart",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
      "idMeal": "52768"
    },

*/

struct MealResponse: Codable {
    let meals: [MealModel]
}

struct MealModel: Identifiable, Codable {
    let strMeal: String
    let strMealThumb: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case strMeal, strMealThumb, id = "idMeal"
    }
}
