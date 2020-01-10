//
//  TransactionsViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 09.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import Foundation
import Combine

typealias Item = DailyTransactionsFeedQuery.Data.DailyTransactionsFeed

final class TransactionsViewModel: ObservableObject {
    
    private var disposeBag: Set<AnyCancellable> = []
    private let apiService: TransactionsService
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    @Published private(set) var transactions: [Transactions] = []
    
    init(apiService: TransactionsService = .init()) {
        self.apiService = apiService
        
        bindInputs()
        //bindOutputs()
    }
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send()
        }
    }
}

private extension TransactionsViewModel {
    func bindInputs() {
        onAppearSubject.sink { [weak self] in
            self?.fetch()
        }
        .store(in: &disposeBag)
    }
    
    func fetch() {
        let result = apiService.fetch().share()

        result
            .map({ $0?.dailyTransactionsFeed })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    print("Not ok!")
                    self.transactions = []
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] transactions in
                    guard let self = self, let transactions = transactions as? [Item] else { return }
                    self.transactions.append(contentsOf: self.process(items: transactions))
            })
            .store(in: &disposeBag)
    }
    
    func process(items: [Item]) -> [Transactions] {
        var showLine = false
        let newItems = items.map { feed -> Transactions in
            var new = Transactions()
            if feed.asDaySectionWidget != nil {
                new.section = TransactionSection(feed.asDaySectionWidget)
                new.section?.showTopLine = showLine
                showLine = true
            } else {
                new.row = TransactionRow(feed.asTransactionWidget)
            }
            return new
        }
        
        return newItems
    }
}
