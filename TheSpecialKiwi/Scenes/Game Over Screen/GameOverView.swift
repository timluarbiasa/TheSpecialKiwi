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
                .onTapGesture {
                    viewModel.retry()
                }
                .navigationDestination(isPresented: $navigateToRoot) {
                    NavigationView()
                        .environmentObject(NavigationViewModel())
                        .transition(.slide) // Apply slide transition here
                }
                .onChange(of: viewModel.shouldRetry) {
                    if viewModel.shouldRetry {
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
