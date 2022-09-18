//
//  TickerListView.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import SwiftUI

struct TickerListView: View {
    @ObservedObject var viewModel: TickerListViewModel
    @State var quarry = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredTickerArray) { element in
                CellView(viewModel: CellViewModel(element: element))
            }.listStyle(.plain)
                .navigationTitle("Tick Tack Crypto")
        }
        .searchable(text: $quarry, placement: .automatic).onChange(of: quarry, perform: { newValue in
            viewModel.filter(for: newValue)
        })
        .safeAreaInset(edge: .bottom) {
            if viewModel.errorAppeared {
                Text("An error occured. Data is not beeing refreshed")
                    .foregroundColor(.white)
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(.red)
            }
        }
    }
}

struct TickerListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TickerListView(viewModel: TickerListViewModel(fetcher: MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.validResponseAll.rawValue) ?? Data()), timerScheduler: Timer.self)).preferredColorScheme($0)
        }
        
    }
}



