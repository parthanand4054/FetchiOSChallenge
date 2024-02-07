//
//  HomeView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel // Reference to the HomeViewModel
    
    @State private var selectedMeal: MealModel? = nil // stores the meal object that we tap on
    @State private var showDetailView: Bool = false // when we tap on a meal row, this is set to true
    
    var body: some View {
        ZStack {
            // Background color
            Color.theme.background
                .ignoresSafeArea()
            
            // Vertically stacks the 3 main views - 1)Header, 2)Custom Search Bar, 3)Meals List
            VStack {
                homeHeader // Simple static header view
                SearchBarView(searchText: $vm.searchText) // Custom search bar view. "searchText" is a published variable in the HomeViewModel. And the SearchBarView has a @Binding property searchText which is being set to $vm.searchText. So the 2 variables are binded or connected.
                allMealsList // Dynamic list of all meals. More details on this in the extension. 
            }
        } // we could create NavigationLink in foreach loop in "allMealsList" view in the extension below, with destination as DetailView & label as MealRowView BUT then it would create the DetailView for all the meal rows at once immediately. We don't want that since each of the detail view will be fetching data from the internet for details. We only want that DetailView to be created for item/meal we tap.
        //So we are just attaching a NavigationLink in the background which will not be visible and it will take us to the detail view we actually want when we want it and not before it. 
        .background(
            NavigationLink(
                destination: DetailLoadingView(meal: $selectedMeal),
                isActive: $showDetailView,
                label: {EmptyView()})
        )
    }
}

// Just for preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject (dev.homeVM)
    }
}

// Extension of the Homeview so that the view is clean
extension HomeView {
    
    // For the app header/title
    private var homeHeader: some View {
        Text("Feast Finder 🍰")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.accent)
            .padding(.top)
    }
    
    // Dynamic list of all the meals. The "allMeals" array (of type [MealModel]) is a published property present in HomeViewModel. So if that updates this view will update with the updated list of meals. Note that this allMeals does not necessarily contain all the meals fetched from the API. That allMeals is in the MealDataService class which has all meals period. This allMeals i.e the one in HomeViewModel is a "filtered" list of meals based on what text the user has in his search bar text box. 
    private var allMealsList: some View {
        List {
            ForEach(vm.allMeals) { meal in
                MealRowView(meal: meal) // Custom row view. "meal" refers to each element of the "allMeals" array. Each "meal" object is of type "MealModel" which has 3 properties - id, name and image url of the meal. So we are passing the meal to the MealRowView because if it has access to the "meal" object then it can show all three properties in each row. We will just show 2 though - name,img
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture { // tap gesture attached to each row of the list.
                        segue(meal: meal) // when any row is clicked, segue function (custom function by created by me) is called and the meal object is passed correspoding to the row that was clicked. Contd..see segue function.
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    // This function is meant to take us to the detailed view. Though it doesnt do that by itself but it sets 2 variables which helps the NavigationLink (attached to our view above) take us to the desired detailed view.
    private func segue(meal: MealModel) {
        selectedMeal = meal
        showDetailView.toggle()
    }
}
