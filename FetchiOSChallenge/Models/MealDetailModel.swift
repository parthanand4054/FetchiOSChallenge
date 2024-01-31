//
//  MealDetailModel.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation

// JSON RESPONSE (FOLDED)
/*
 URL:  https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
 https://themealdb.com/api/json/v1/1/lookup.php?i=53049
 
 
 // JSON RESPONSE FOR MEAL DETAIL ()
 
 
 {
   "meals": [
     {
       "idMeal": "53049",
       "strMeal": "Apam balik",
       "strDrinkAlternate": null,
       "strCategory": "Dessert",
       "strArea": "Malaysian",
       "strInstructions": "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.",
       "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
       "strTags": null,
       "strYoutube": "https://www.youtube.com/watch?v=6R8ffRRJcrg",
       "strIngredient1": "Milk",
       "strIngredient2": "Oil",
       "strIngredient3": "Eggs",
       "strIngredient4": "Flour",
       "strIngredient5": "Baking Powder",
       "strIngredient6": "Salt",
       "strIngredient7": "Unsalted Butter",
       "strIngredient8": "Sugar",
       "strIngredient9": "Peanut Butter",
       "strIngredient10": "",
       "strIngredient11": "",
       "strIngredient12": "",
       "strIngredient13": "",
       "strIngredient14": "",
       "strIngredient15": "",
       "strIngredient16": "",
       "strIngredient17": "",
       "strIngredient18": "",
       "strIngredient19": "",
       "strIngredient20": "",
       "strMeasure1": "200ml",
       "strMeasure2": "60ml",
       "strMeasure3": "2",
       "strMeasure4": "1600g",
       "strMeasure5": "3 tsp",
       "strMeasure6": "1/2 tsp",
       "strMeasure7": "25g",
       "strMeasure8": "45g",
       "strMeasure9": "3 tbs",
       "strMeasure10": " ",
       "strMeasure11": " ",
       "strMeasure12": " ",
       "strMeasure13": " ",
       "strMeasure14": " ",
       "strMeasure15": " ",
       "strMeasure16": " ",
       "strMeasure17": " ",
       "strMeasure18": " ",
       "strMeasure19": " ",
       "strMeasure20": " ",
       "strSource": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
       "strImageSource": null,
       "strCreativeCommonsConfirmed": null,
       "dateModified": null
     }
   ]
 }
 
 */

struct DetailedMealResponse: Codable {
    let meals: [DetailedMeal]
}

struct DetailedMeal: Identifiable, Codable {
    let id: String?
    let strMeal: String?
    let strInstructions: String?
    var ingredients: [String] {
        var ingreds = [String]()
        if let ingredient = strIngredient1, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient2, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient3, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient4, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient5, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient6, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient7, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient8, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient9, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient10, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient11, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient12, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient13, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient14, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient15, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient16, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient17, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient18, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient19, !ingredient.isEmpty { ingreds.append(ingredient) }
        if let ingredient = strIngredient20, !ingredient.isEmpty { ingreds.append(ingredient) }
        return ingreds
    }
    var measures: [String] {
        var meas = [String]()
        if let measure = strMeasure1, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure2, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure3, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure4, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure5, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure6, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure7, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure8, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure9, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure10, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure11, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure12, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure13, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure14, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure15, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure16, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure17, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure18, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure19, !measure.isEmpty { meas.append(measure) }
        if let measure = strMeasure20, !measure.isEmpty { meas.append(measure) }
        return meas
    }

    // Make all ingredient and measure properties optional
    private let strIngredient1: String?
    private let strIngredient2: String?
    private let strIngredient3: String?
    private let strIngredient4: String?
    private let strIngredient5: String?
    private let strIngredient6: String?
    private let strIngredient7: String?
    private let strIngredient8: String?
    private let strIngredient9: String?
    private let strIngredient10: String?
    private let strIngredient11: String?
    private let strIngredient12: String?
    private let strIngredient13: String?
    private let strIngredient14: String?
    private let strIngredient15: String?
    private let strIngredient16: String?
    private let strIngredient17: String?
    private let strIngredient18: String?
    private let strIngredient19: String?
    private let strIngredient20: String?
    // Repeat for all ingredient fields up to strIngredient20

    private let strMeasure1: String?
    private let strMeasure2: String?
    private let strMeasure3: String?
    private let strMeasure4: String?
    private let strMeasure5: String?
    private let strMeasure6: String?
    private let strMeasure7: String?
    private let strMeasure8: String?
    private let strMeasure9: String?
    private let strMeasure10: String?
    private let strMeasure11: String?
    private let strMeasure12: String?
    private let strMeasure13: String?
    private let strMeasure14: String?
    private let strMeasure15: String?
    private let strMeasure16: String?
    private let strMeasure17: String?
    private let strMeasure18: String?
    private let strMeasure19: String?
    private let strMeasure20: String?
    // Repeat for all measure fields up to strMeasure20

    enum CodingKeys: String, CodingKey {
        case strMeal, strInstructions, id = "idMeal"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7,
             strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14,
             strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9,
             strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17,
             strMeasure18, strMeasure19, strMeasure20
    }
}

