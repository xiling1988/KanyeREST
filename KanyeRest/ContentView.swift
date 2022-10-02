//
//  ContentView.swift
//  KanyeRest
//
//  Created by Emirates on 09/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var vm = KanyeQuoteViewModel()
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Text("Random Kanye Quotes")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .frame(width: 350, height: 160, alignment: .center)
                Spacer()
                Text(vm.quote.quote)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Button(action: vm.getRandomQuote) {
                    Text("Get new Random Quote")
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 15)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
