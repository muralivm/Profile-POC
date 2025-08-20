//
//  ProfileDetailView.swift
//  ProfilePOC
//
//  Created by M, Murali on 20/08/25.
//
import SwiftUI

// MARK: - Profile Detail View
struct ProfileDetailView: View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 20) {
            Image(profile.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
            
            Text(profile.name)
                .font(.largeTitle)
                .bold()
            
            Text("\(profile.age) years old")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text(profile.bio)
                .font(.body)
                .padding()
                    }
        .navigationTitle("Profile Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
