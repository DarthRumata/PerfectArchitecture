//
//  Product.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import Foundation

public class Product: EntityType {
    public struct Rating {
        public let rating: String
        public let reviews: String
        
        public init(rating: String, reviews: String) {
            self.rating = rating
            self.reviews = reviews
        }
    }
    
    public let id: Int
    public let winery: String
    public let wine: String
    public let rating: Rating
    
    public init(id: Int, winery: String, wine: String, rating: Rating) {
        self.id = id
        self.winery = winery
        self.wine = wine
        self.rating = rating
    }
    
    public var value: ProductValue {
        return ProductValue(product: self)
    }
    
    public func update(with entity: Product) {
        
    }
}

public struct ProductValue {
    public var id: Int {
        return product.id
    }
    public var winery: String {
        return product.winery
    }
    public var wine: String {
        return product.wine
    }
    public var rating: String {
        product.rating.rating
    }
    public var reviews: String {
        product.rating.reviews
    }
    
    private let product: Product
    
    public init(product: Product) {
        self.product = product
    }
}
