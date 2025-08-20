//
//  ProfileCardView.swift
//  ProfilePOC
//
//  Created by M, Murali on 20/08/25.
//
import SwiftUI

struct ProfileCardView: View {
    let profile: Profile
    var onSwipe: (_ liked: Bool) -> Void
    var onTap: () -> Void
    @State private var offset: CGSize = .zero
    @State private var swipeStatus: SwipeStatus = .none
    @State private var overlayOpacity: Double = 0
    @State private var overlayScale: CGFloat = 1.0
    
    enum SwipeStatus {
        case like, dislike, none
    }
    
    var body: some View {
        ZStack {
            // Profile Image with info overlay
            Image(profile.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 500)
                .clipped()
                .cornerRadius(20)
                .shadow(radius: 5)
                .overlay(
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("\(profile.name), \(profile.age)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                        Text(profile.bio)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                            .shadow(radius: 10)
                    }
                    .padding()
                )// For "LIKE" at top-left
                .overlay(
                    Group {
                        if swipeStatus == .like {
                            Text("LIKE")
                                .font(.system(size: 70, weight: .bold))
                                .foregroundColor(.green)
                                .padding(30)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.green.opacity(0.8))
                                )
                                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 4)
                                .rotationEffect(.degrees(-20))
                                .scaleEffect(overlayScale)
                                .opacity(overlayOpacity)
                                .animation(.easeInOut(duration: 0.3), value: overlayOpacity)
                                .position(x: 80, y: 80)
                        }
                    }
                )

                // For "NOPE" at top-right
                .overlay(
                    Group {
                        if swipeStatus == .dislike {
                            Text("NOPE")
                                .font(.system(size: 70, weight: .bold))
                                .foregroundColor(.red)
                                .padding(30)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.red.opacity(0.8))
                                )
                                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 4)
                                .rotationEffect(.degrees(20))
                                .scaleEffect(overlayScale)
                                .opacity(overlayOpacity)
                                .animation(.easeInOut(duration: 0.3), value: overlayOpacity)
                                .position(x: UIScreen.main.bounds.width - 80, y: 80)
                        }
                    }
                )
        }.onTapGesture {
            onTap()
        }
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                        offset = gesture.translation
                        if offset.width > 100 {
                            swipeStatus = .like
                            overlayOpacity = min(Double((offset.width - 100) / 100), 1)
                            overlayScale = 1.2
                        } else if offset.width < -100 {
                            swipeStatus = .dislike
                            overlayOpacity = min(Double((-offset.width - 100) / 100), 1)
                            overlayScale = 1.2
                        } else {
                            swipeStatus = .none
                            overlayOpacity = 0
                            overlayScale = 1.0
                        }
                    }
                }
                .onEnded { _ in
                    if swipeStatus == .like {
                        withAnimation(.spring()) {
                            offset = CGSize(width: 1000, height: 0)
                            overlayOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            offset = .zero
                            swipeStatus = .none
                            onSwipe(true)
                        }
                    } else if swipeStatus == .dislike {
                        withAnimation(.spring()) {
                            offset = CGSize(width: -1000, height: 0)
                            overlayOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            offset = .zero
                            swipeStatus = .none
                            onSwipe(false)
                        }
                    } else {
                        withAnimation(.spring()) {
                            offset = .zero
                            overlayOpacity = 0
                            overlayScale = 1.0
                        }
                    }
                }
        )
    }
}
