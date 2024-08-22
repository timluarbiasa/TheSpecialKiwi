//
//  GameOverView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 20/08/24.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: GameOverViewModel
    @State var navigateToRoot = false
    
    var body: some View {
        NavigationStack {
            Image("GameResultOverlay")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .fullScreenCover(isPresented: $navigateToRoot) {
                    NavigationView()
                        .environmentObject(NavigationViewModel())
                        .transition(.scale) // No transition effect when presenting the new view
                }
                .onAppear{
                    viewModel.stopSound()
                    print("GameOver: stop sound")
                }
                .onTapGesture {
                    viewModel.retry()
                }
                .onChange(of: viewModel.shouldRetry) { shouldRetry in
                    if shouldRetry {
                        withAnimation {
                            navigateToRoot = true
                        }
                    }
                }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(viewModel: GameOverViewModel())
    }
}
