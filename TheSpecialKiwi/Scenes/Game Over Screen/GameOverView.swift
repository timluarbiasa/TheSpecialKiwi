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
            .background(
                NavigationLink(destination: NavigationView().environmentObject(NavigationViewModel()), isActive: $navigateToRoot) {
                    EmptyView()
                }
                    .hidden()
            )
            .onTapGesture {
                viewModel.retry()
            }
            .onChange(of: viewModel.shouldRetry) { shouldRetry in
                if shouldRetry {
                    navigateToRoot = true
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
