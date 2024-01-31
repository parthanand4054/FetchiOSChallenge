//
//  FetchiOSChallengeApp.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand a
//

import SwiftUI

@main
struct FetchiOSChallengeApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
