//
//  ProductListCell.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import SwiftUI
import Combine
import CommonLogic

struct ProductListCellModel: Identifiable {
    let id: Int
    let winery: String
    let wine: String
    let rating: String
    
    init(product: ProductValue) {
        self.id = product.id
        self.winery = product.winery
        self.wine = product.wine
        self.rating = product.rating
    }
}

struct ProductListCell: View {
    private let viewModel: ProductListCellModel
    
    init(viewModel: ProductListCellModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(viewModel.winery).foregroundColor(.red)
                Text(viewModel.wine)
            }
            Spacer()
            Text(viewModel.rating)
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static let product = Product(id: 1, winery: "Maselva", wine: "Emporda 2012", rating: Product.Rating(rating: "4.9", reviews: "46"))
    static var previews: some View {
        ProductListCell(viewModel: ProductListCellModel(product: ProductValue(product: product)))
    }
}
