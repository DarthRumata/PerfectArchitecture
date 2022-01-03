//
//  ProductListRootView.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import SwiftUI
import Combine

struct ProductListViewModel {
    let isLoading: AnyPublisher<Bool, Never>
    let viewModels: AnyPublisher< [ProductListCellModel], Never>
}

struct ProductListRootView: View {
    private let viewModel: ProductListViewModel
    @State private var cellViewModels = [ProductListCellModel]()
    @State private var isLoaderHidden = true
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            List(cellViewModels) { model in
                ProductListCell(viewModel: model)
            }
            .onReceive(viewModel.viewModels) { viewModels in
                self.cellViewModels = viewModels
            }
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                .onReceive(viewModel.isLoading) { isLoading in
                    self.isLoaderHidden = !isLoading
                }
                .isHidden(isLoaderHidden)
        }
    }
}

struct ProductListRootView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductListViewModel(isLoading: Just(false).eraseToAnyPublisher(), viewModels: Just([]).eraseToAnyPublisher())
        ProductListRootView(viewModel: viewModel)
    }
}
