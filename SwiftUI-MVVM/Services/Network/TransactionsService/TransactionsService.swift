//
//  TransactionsService.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 08.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import Foundation
import Combine
import Apollo

typealias FeedData = DailyTransactionsFeedQuery.Data

protocol TransactionsServiceProtocol {
    func fetch() -> AnyPublisher<FeedData?, Error>
}

final class TransactionsService: TransactionsServiceProtocol {
    func fetch() -> AnyPublisher<FeedData?, Error> {
        APIClient.shared.apollo.fetchPublisher(query: DailyTransactionsFeedQuery())
    }
}
