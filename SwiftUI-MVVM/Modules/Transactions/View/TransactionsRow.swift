//
//  TransactionsRow.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 09.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import SwiftUI

struct TransactionsRow: View {
    @State var transaction: Transactions
    var showLine: Bool = false

    var body: some View {
        content()
    }
}

private extension TransactionsRow {
    var fontColor: Color {
        transaction.row?.type == .cashback ? Color("cashbackFont") : Color("regularFont")
    }
    
    var iconColor: Color {
        transaction.row?.type == .cashback ? Color("brandGreen") : Color("regularIcon")
    }
    
    var backgroundColor: Color {
        transaction.row?.type == .cashback ? Color("brandGreen") : .white
    }
    
    var lineHeight: CGFloat {
        transaction.section?.showTopLine == true ? 12 : 0
    }
    
    func content() -> some View {
        if transaction.section != nil {
            return AnyView(createHeader())
        } else {
            return AnyView(createRow())
        }
    }
    
    func createHeader() -> some View {
        VStack {
            VStack {
                Text(" ")
                    .frame(width: UIScreen.main.bounds.width, height: lineHeight, alignment: .leading)
                    .background(iconColor.edgesIgnoringSafeArea(.all))
                Text(" ")
                    .frame(width: UIScreen.main.bounds.width, height: lineHeight, alignment: .leading)
            }

            HStack(alignment: .center, spacing: 0) {
                Text(transaction.section?.date ?? "")
                    .font(.system(size: 16))
                    .foregroundColor(Color.gray)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                Spacer()
                
                Text(transaction.section?.amount ?? "")
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
        }
        .padding(EdgeInsets(top: 0, leading: -16, bottom: 0, trailing: 0))
    }
    
    func createRow() -> some View {
        HStack(alignment: .center, spacing: 0) {
            HStack {
                Image(transaction.row?.image ?? "")
                    //.resizable()
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
            .frame(width: 50, height: 50, alignment: .center)
            .background(iconColor.edgesIgnoringSafeArea(.all))
            .cornerRadius(18)
            .clipped()
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))

            Text(transaction.row?.title ?? "")
                .font(.system(size: 15))
                .foregroundColor(fontColor)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 16))
            
            Spacer()
            
            Text(transaction.row?.amount ?? "")
                .font(.system(size: 15))
                .foregroundColor(fontColor)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
        }
        .aspectRatio(contentMode: .fill)
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        .cornerRadius(8)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct TransactionsRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsRow(transaction: .init())
    }
}
