//
//  CellView.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import SwiftUI

struct CellView: View {
    let viewModel: CellViewModel
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            HStack {

                VStack(alignment: .leading) {
                    Text(viewModel.name).font(.headline).multilineTextAlignment(.leading).padding(.bottom, 5.0)
                    Text(viewModel.abbriviation).font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.leading)
                }.padding([.top, .leading, .bottom], 10.0)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(viewModel.value)
                        .font(.headline)
                        .padding(.bottom, 5.0)
                        
                    Text(viewModel.change)
                        .font(.subheadline)
                        .foregroundColor(viewModel.isNegative ? .red : .green)
                } .padding([.top, .bottom, .trailing], 10.0)
            }
            .background()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(viewModel.isNegative ? .red : .green, lineWidth: 0.5)
            
        )
        .shadow(color: viewModel.isNegative ? .red : .green, radius: 3)
        .listRowSeparator(.hidden)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TickerListView(viewModel: TickerListViewModel(fetcher: MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.validResponseAll.rawValue) ?? Data()), timerScheduler: Timer.self)).preferredColorScheme($0)
        }
        
    }
}

