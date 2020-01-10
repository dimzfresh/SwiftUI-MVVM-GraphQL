//
//  TransactionsView.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 08.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    private var first = true
    
    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        
        setup()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.transactions) { transaction in
                TransactionsRow(transaction: transaction)
            }
                //        .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                //            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                //        })
            .listStyle(PlainListStyle())
            .navigationBarTitle(Text("Transactions"))
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
        }
    }
}

private extension TransactionsView {
    func setup() {
        UIView.setAnimationsEnabled(false)
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: .init())
    }
}
