//
//  HomeView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedMeal: MealModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeader
                SearchBarView(searchText: $vm.searchText)
                allMealsList
            }
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(meal: $selectedMeal),
                isActive: $showDetailView,
                label: {EmptyView()})
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject (dev.homeVM)
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        Text("Feast Finder 🍰")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.accent)
            .padding(.top)
    }
    
    private var allMealsList: some View {
        List {
            ForEach(vm.allMeals) { meal in
                MealRowView(meal: meal)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(meal: meal)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(meal: MealModel) {
        selectedMeal = meal
        showDetailView.toggle()
    }
}
