//
//  ContentView.swift
//  ProfilePOC
//
//  Created by M, Murali on 20/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ProfilesViewModel()
    @State private var showDetail = false
    @State private var selectedProfile: Profile? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if let profile = viewModel.currentProfile {
                    ProfileCardView(profile: profile, onSwipe: { liked in
                        viewModel.moveToNextProfile()
                    }, onTap: {
                        selectedProfile = profile
                        showDetail = true
                    })
                    .padding()
                } else {
                    Text("No more profiles")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .navigationTitle("Discover")
            // New modifier for navigation
            .navigationDestination(isPresented: $showDetail) {
                if let profile = selectedProfile {
                    ProfileDetailView(profile: profile)
                } else {
                    Text("No profile selected")
                }
            }
        }
    }
}
