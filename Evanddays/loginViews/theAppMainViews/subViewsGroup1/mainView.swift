//
//  mainView.swift
//  Evanddays
//
//  Created by David on 4/28/24.
//
//

import SwiftUI
import AVKit

//struct mainView: View {
//    var PInfo: parcelInfo
//    @State private var player = AVPlayer()
//    
//    
//    var body: some View {
//    
//        ScrollView{
//            VStack(alignment: .center, spacing: 10) {
//                Image(systemName: "gear") // Replace with your image name
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 120, height: 120)
//                    .clipShape(Circle())
//                    .shadow(radius: 3)
//                    .foregroundColor(.white)
//                    .padding(.top, 20)
//                
//                Text("\(PInfo.parcelName)") // Replace with the actual username
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                
//                Text("1,000 Followers") // Replace with the actual follower count
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//                    .padding(.vertical,10)
//                Text("Event ID:\(PInfo.ID) ")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.bottom,10)
//                
//                // Additional profile information can be added here
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color.black)
//            .cornerRadius(20)
//            .padding()
//            //
//
//            NavigationView {
//                List {
//                    // Loop to create multiple rows
//                    VideoPlayer(player: player)
//                    
//                        .frame(width: 360,height: 640)
//                        .cornerRadius(12)
//                        .padding()
//                  
//                   
//                }
//                
//                .navigationTitle("Posts") // Set the navigation bar title
//               
//            }
//            .frame(height: 710)
//            .padding(-1)
//            .cornerRadius(20)
//            .background(Color.black)
//            .padding(.leading, -20)
//            .padding(.trailing, -20)
//            .cornerRadius(30)
//            
//        }
//        .scrollBounceBehavior(.basedOnSize)
//        .task{
//            await getVideos()
//        }
//        
//        
//        
//    }
//    
//
//    private func getVideos() async {
//         let EID = PInfo.ID
//        guard let url = URL(string: "http://:3000/get-Videos?IDSent=\(EID)")else{
//            print("Invalid URL")
//            return
//        }
//        player = AVPlayer(url: url)
//        player.play()
//
//    }
//}



import SwiftUI
import AVKit
import Combine


struct mainView: View {
    var PInfo: parcelInfo

    var body: some View {
        ScrollView{
                        VStack(alignment: .center, spacing: 10) {
                            Image(systemName: "gear") // Replace with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                                .foregroundColor(.white)
                                .padding(.top, 20)
            
                            Text("\(PInfo.parcelName)") // Replace with the actual username
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
            
                            Text("1,000 Followers") // Replace with the actual follower count
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.vertical,10)
                            Text("Event ID:\(PInfo.ID) ")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom,10)
            
                            // Additional profile information can be added here
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding()
            VideosView(PInfo: PInfo)
        }
        .background(Color.white)
        
        .scrollBounceBehavior(.basedOnSize)
    }
}

struct VideosView: View {
    var PInfo: parcelInfo
    @State private var videoURLs: [URL] = []  // Store the video URLs
    @State private var videoPlayers: [Int: AVPlayer] = [:]  // Dictionary to hold players for loaded videos
    @State private var currentIndex: Int = 0  // Track the current video index
    @State private var cancellables: Set<AnyCancellable> = []  // Keep track of subscriptions
    @State private var isLoadingMoreVideos: Bool = false  // Track if more videos are being loaded

    var body: some View {
        VStack {
//            if videoURLs.isEmpty {
//                Text("Loading videos...")
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9)
//                
//            } else {
//                Group {
//                    if let player = videoPlayers[currentIndex] {
//                        VideoPlayer(player: player)
//                            .onAppear {
//                                playOnlyCurrentVideo(index: currentIndex)
//                                if currentIndex == videoURLs.count - 1 {  // Last video appears
//                                    loadMoreVideos()
//                                }
//                            }
//                            .onDisappear {
//                                // Pause and reset the video when the view disappears
//                                pauseAndResetVideo(index: currentIndex)
//                            }
//                    } else {
//                        Text("Loading Video \(currentIndex + 1)")
//                            .onAppear {
//                                loadVideoPlayer(at: currentIndex)
//                                if currentIndex == videoURLs.count - 1 {  // Last video appears
//                                    loadMoreVideos()
//                                }
//                            }
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9)
            if videoURLs.isEmpty {
                     // Display a progress wheel with a white background when loading videos
                     ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                         .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9)
                         .background(Color.white)
                        
                 } else {
                     Group {
                         if let player = videoPlayers[currentIndex] {
                             VideoPlayer(player: player)
                                 .onAppear {
                                     playOnlyCurrentVideo(index: currentIndex)
                                     if currentIndex == videoURLs.count - 1 {  // Last video appears
                                         loadMoreVideos()
                                     }
                                 }
                                 .onDisappear {
                                     // Pause and reset the video when the view disappears
                                     pauseAndResetVideo(index: currentIndex)
                                 }
                         } else {
                             // Display a progress wheel with a white background while loading the specific video
                             ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                 .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9)
                                 .background(Color.white)
                                 .onAppear {
                                     loadVideoPlayer(at: currentIndex)
                                     if currentIndex == videoURLs.count - 1 {  // Last video appears
                                         loadMoreVideos()
                                     }
                                 }
                         }
                     }
                     .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 16 / 9)

                // Swipe gesture area
                Text("<-- Swipe -->")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 50 && currentIndex > 0 {
                                    // Swipe right to left: move to previous video
                                    currentIndex -= 1
                                    playOnlyCurrentVideo(index: currentIndex)
                                } else if gesture.translation.width < -50 && currentIndex < videoURLs.count - 1 {
                                    // Swipe left to right: move to next video
                                    currentIndex += 1
                                    playOnlyCurrentVideo(index: currentIndex)
                                }
                            }
                    )
                    .padding(.top, 10)
            }
        }
       
        .task {
                await loadVideoURLs()
            }
        
    }

    func loadVideoURLs() async {
        print("check 1:\(Thread.isMainThread)")
        print("check 1:\(Thread.current)")
        let eID = PInfo.ID
        guard let url = URL(string: "http://192.168.1.21:3000/get-Videos?IDSent=\(eID)") else {
            print("Invalid URL")
            return
        }

        do {
            print("check 2:\(Thread.isMainThread)")
            print("check 2:\(Thread.current)")
            let (data, _) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async {
                do {
                    print("check 3:\(Thread.isMainThread)")
                    print("check 3:\(Thread.current)")
                    let decoded = try JSONDecoder().decode(Response.self, from: data)
                    self.videoURLs.append(contentsOf: decoded.videoURLs)
                    // Pre-load the video for the first index if not loaded yet
                    if self.videoPlayers.isEmpty {
                        self.loadVideoPlayer(at: 0)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Network error: \(error.localizedDescription)")
        }
    }

    func loadVideoPlayer(at index: Int) {
        guard videoPlayers[index] == nil, index < videoURLs.count else { return }

        let player = AVPlayer(url: videoURLs[index])
        videoPlayers[index] = player
        setupEndPlaybackObserver(player: player, index: index)

        if index == currentIndex {
            playOnlyCurrentVideo(index: index)
        }
    }

    private func playOnlyCurrentVideo(index: Int) {
        // Play the current video and ensure all others are paused
        for (i, player) in videoPlayers {
            if i == index {
                player.play()
            } else {
                player.pause()
                player.seek(to: CMTime.zero)
            }
        }
    }

    private func setupEndPlaybackObserver(player: AVPlayer, index: Int) {
        // Observe the end of the video
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            .sink { _ in
                // Restart the video when it finishes
                videoPlayers[index]?.seek(to: CMTime.zero)
                videoPlayers[index]?.play()
            }
            .store(in: &cancellables)  // Store the cancellable to keep it alive
    }

    private func pauseAndResetVideo(index: Int) {
        // Pause the video and reset its position
        videoPlayers[index]?.pause()
        videoPlayers[index]?.seek(to: CMTime.zero)
    }

    private func loadMoreVideos() {
        guard !isLoadingMoreVideos else { return }
        isLoadingMoreVideos = true

        // Simulate a network request for more videos
        Task {
            await loadVideoURLs()
            isLoadingMoreVideos = false
        }
    }
}

// Dummy data for preview purposes

// Preview
#Preview {
    mainView(PInfo: parcelInfo())
}
