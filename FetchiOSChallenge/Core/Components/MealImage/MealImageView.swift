//
//  MealImageView.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import SwiftUI

struct MealImageView: View {
    
    // I essentially wanted to create an object of MealImageViewModel class & also pass "meal" in its initializer since the meal variable is needed by that class. Also this object of MealImageViewModel needs to be a StateObject since there are published variables in that class that need to be listened to and make necessary changes in our UI in this Struct.
    // We can't do something like this:
    // let meal: MealModel -> 1st line
    // @StateObejct var vm = MealImageViewModel(meal: meal) -> 2nd line
    // can't do this since the value of meal is set in the init function and so meal cannot be used while initializing the vm in the 2nd line. Also we can't set the meal value in init and then in init initialize the MealImageViewModel(meal: meal) since we will have to assign it to the vm here: @StateObject var vm: MealImageViewModel but we cant assign anything to the state object like this.

    
// Here is how we do it correctly below:
//    Creating a Normal Object: You correctly create an instance of MealImageViewModel using MealImageViewModel(meal: meal). This is just like creating any normal object in Swift, where meal is passed to its initializer.
//    Making It a State Object: Instead of assigning this object directly to vm (which isn't allowed because vm is managed by SwiftUI as a @StateObject), you use _vm. The underscore _ prefix accesses the underlying storage for the vm property. This is a special capability in SwiftUI that lets you interact directly with the property wrapper storage.
//    Using StateObject(wrappedValue:): By passing your MealImageViewModel instance to StateObject(wrappedValue:), you're effectively wrapping your model in a StateObject. This tells SwiftUI, "Here's the object I want you to manage as a state object." SwiftUI then takes over, ensuring vm is only created once and is preserved across view updates.
    
    @StateObject var vm: MealImageViewModel
    
    init(meal: MealModel) {
        _vm = StateObject(wrappedValue: MealImageViewModel(meal: meal))
    }
    
    var body: some View {
        ZStack {
            // Image is a published variable inside the MealImageViewModel so we access it vm.image and keep listening. once we have it we will get it in the image variable on the left. And then we set the image.
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading { // isLoading is also a published variable in MealImageViewModel class. we keep listening to it here. if it is true that means we dont have the image yet and that we should show progress view.
                ProgressView()
            } else { // if finally we don't have the image yet and also isLoading is false then that means there is no image for that meal so we set the image to question mark. 
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
