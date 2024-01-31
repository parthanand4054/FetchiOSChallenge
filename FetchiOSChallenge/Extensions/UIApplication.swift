//
//  UIApplication.swift
//  FetchiOSChallenge
//
//  Created by Parth Anand 
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
