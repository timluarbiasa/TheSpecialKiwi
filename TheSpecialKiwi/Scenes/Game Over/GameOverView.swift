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
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
                
                Button(action: {
                    viewModel.retry()
                }) {
                    Text("Retry")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(
                NavigationLink(destination: NavigationView().environmentObject(NavigationViewModel()), isActive: $navigateToRoot) {
                    EmptyView()
                }
                    .hidden()
            )
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
