//
//  Transactions.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 09.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import UIKit

struct Transactions: Hashable, Identifiable  {
    var id: String
    var section: TransactionSection?
    var row: TransactionRow?
    
    init() {
        self.id = UUID().uuidString
    }
}

struct TransactionSection: Hashable {
    let date: String
    let amount: String
    let currencyCode: CurrencyCode
    var showTopLine: Bool = false

    init(_ data: Item.AsDaySectionWidget?) {
        self.date = (data?.date ?? "").toDate().toString()
        self.currencyCode = data?.amount.currencyCode ?? .gbp
        
        var amount = data?.amount.value ?? ""
        if amount.count > 2 {
            amount.insert(Character(currencyCode.symbol), at: amount.index(amount.startIndex, offsetBy: 1))
        }
        self.amount = amount
    }
}

struct TransactionRow: Hashable {
    let amount: String
    let currencyCode: CurrencyCode
    let title: String
    let type: TransactionType
    let image: String
    
    init(_ data: Item.AsTransactionWidget?) {
        //self.date = data.date.toDate()
        var amount = data?.transaction.amount.value ?? ""
        self.type = data?.transaction.type ?? .regular
        self.currencyCode = data?.transaction.amount.currencyCode ?? .gbp
        if self.type == .cashback {
            self.image = "cashback"
        } else {
            self.image = data?.image?.iconName ?? ""
        }

        if amount.count > 2 {
            if self.type == .cashback {
                amount = "+\(amount)"
                amount.insert(Character(currencyCode.symbol), at: amount.index(amount.startIndex, offsetBy: 1))
            } else {
                amount.insert(Character(currencyCode.symbol), at: amount.index(amount.startIndex, offsetBy: 1))
            }
        }
        self.amount = amount
        self.title = data?.transaction.title ?? ""
    }
}


extension CurrencyCode {
    var symbol: String {
        switch self {
        case .gbp:
            return "£"
        case .rub:
            return "₽"
        case .usd:
            return "$"
        default:
            return "£"
        }
    }
}
