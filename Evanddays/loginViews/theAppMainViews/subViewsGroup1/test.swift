//
//  test.swift
//  Evanddays
//
//  Created by David on 5/7/24.
//

import SwiftUI

struct ReelsView: View {
    // Example data for the rectangles
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]

    var body: some View {
        
        TabView {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .fill(color)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(Text("Swipe Up for Next").foregroundColor(.white))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never)) // Hide the page indicator
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9) // Set the 9:16 aspect ratio based on the screen width
        .edgesIgnoringSafeArea(.all) // Optional: Ignore safe area to make the view fullscreen
    }
    
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}

//import SwiftUI
//
//struct ReelsView: View {
//    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]
//    @State private var currentIndex = 0
//    @GestureState private var dragState = DragState.inactive
//    private let dragThreshold: CGFloat = 80.0
//
//    enum DragState {
//        case inactive
//        case dragging(translation: CGSize)
//
//        var translation: CGSize {
//            switch self {
//            case .inactive:
//                return .zero
//            case .dragging(let t):
//                return t
//            }
//        }
//
//        var isDragging: Bool {
//            switch self {
//            case .inactive:
//                return false
//            case .dragging:
//                return true
//            }
//        }
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                Rectangle()
//                    .fill(colors[currentIndex % colors.count])
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .overlay(Text("Swipe Up for Next").foregroundColor(.white))
//                    .gesture(
//                        DragGesture()
//                            .updating($dragState) { drag, state, _ in
//                                state = .dragging(translation: drag.translation)
//                            }
//                            .onEnded { drag in
//                                if drag.translation.height < -self.dragThreshold {
//                                    self.currentIndex += 1
//                                } else if drag.translation.height > self.dragThreshold {
//                                    self.currentIndex = max(0, self.currentIndex - 1)
//                                }
//                            }
//                    )
//                    .animation(.interactiveSpring(), value: currentIndex)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}


//import SwiftUI
//import AVKit
//
//struct ReelsView: View {
//    var PInfo: parcelInfo
//    @State private var player = AVPlayer()
//    @State private var currentIndex = 0
//    @GestureState private var isDragging = false
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                VideoPlayer(player: player)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .cornerRadius(12)
//                    .padding()
//                    .gesture(
//                        DragGesture()
//                            .updating($isDragging) { _, state, _ in
//                                state = true
//                            }
//                            .onEnded { drag in
//                                if drag.translation.height < -50 && drag.predictedEndTranslation.height < -100 {
//                                    currentIndex += 1
//                                    Task {
//                                        await loadVideo()
//                                    }
//                                } else if drag.translation.height > 50 && drag.predictedEndTranslation.height > 100 {
//                                    currentIndex = max(currentIndex - 1, 0)
//                                    Task {
//                                        await loadVideo()
//                                    }
//                                }
//                            }
//                    )
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
//        .edgesIgnoringSafeArea(.all)
//        .task {
//            await loadVideo()
//        }
//    }
//
//    private func loadVideo() async {
//        let EID = PInfo.ID
//        guard let url = URL(string: "http://:3000/get-Videos?IDSent=\(EID)") else {
//            print("Invalid URL")
//            return
//        }
//        player = AVPlayer(url: url)
//        player.play()
//    }
//}
//
//#Preview{
//        ReelsView(PInfo: parcelInfo())
//    }


//import SwiftUI
//import AVKit

//struct ReelsView: View {
//    var PInfo: parcelInfo
//    @State private var player = AVPlayer()
//    @State private var currentIndex = 0
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .trailing) {
//                VideoPlayer(player: player)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .cornerRadius(12)
//                    .padding()
//                
//                // Button to change the video
//                Button(action: {
//                    currentIndex += 1
//                    Task {
//                        await loadVideo()
//                    }
//                }) {
//                    Image(systemName: "chevron.right.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .opacity(0.5)  // Make the button slightly translucent
//                }
//                .padding(.trailing, 20)  // Space from the right edge
//                .frame(height: geometry.size.height)  // Make the button easy to tap
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
//        .edgesIgnoringSafeArea(.all)
//        .task {
//            await loadVideo()
//        }
//    }
//
//    private func loadVideo() async {
//        let EID = PInfo.ID
//        guard let url = URL(string: "http://:3000/get-Videos?IDSent=\(EID)") else {
//            print("Invalid URL")
//            return
//        }
//        player = AVPlayer(url: url)
//        player.play()
//    }
//}
//
//import AVKit
//
//struct ReelsView: View{
//    var url = URL(string: "http://localhost:3000/data/Videos/P1WC1C1S1SC1CT1N1UP2/reel_1.mp4")!
//    var body: some View{
//        NavigationStack{
//            
//            VideoPlayer(player: AVPlayer(url: url))
//        }
//    }
//}
//
//
//
//struct ReelsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReelsView()
//    }
//}
//




// Assume ParcelInfo is correctly defined somewhere in your project
