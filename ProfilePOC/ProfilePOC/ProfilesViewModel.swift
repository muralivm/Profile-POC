//
//  ProfilesViewModel.swift
//  ProfilePOC
//
//  Created by M, Murali on 20/08/25.
//

import SwiftUI

// MARK: - Model
struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let imageName: String
    let bio: String
}

// MARK: - ViewModel
class ProfilesViewModel: ObservableObject {
    @Published var profiles: [Profile] = [
        Profile(name: "Alice", age: 25, imageName: "person1", bio: "Loves hiking and outdoor adventures."),
        Profile(name: "Bob", age: 30, imageName: "person2", bio: "Tech enthusiast and coffee lover."),
        Profile(name: "Charlie", age: 28, imageName: "person3", bio: "Musician and foodie."),
    ]
    
    @Published var currentIndex: Int = 0
    
    var currentProfile: Profile? {
        guard currentIndex < profiles.count else { return nil }
        return profiles[currentIndex]
    }
    
    func moveToNextProfile() {
        if currentIndex < profiles.count - 1 {
            currentIndex += 1
        } else {
             currentIndex = 0
        }
    }
}
