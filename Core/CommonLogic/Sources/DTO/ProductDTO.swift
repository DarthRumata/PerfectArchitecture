//
//  ProductDTO.swift
//  CommonLogic
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import Foundation

public struct ProductDTO: Decodable {
    struct RatingDTO: Decodable {
        let average: String
        let reviews: String
        
        func makeEntity() -> Product.Rating {
            return Product.Rating(rating: average, reviews: reviews)
        }
    }
    
    let id: Int
    let winery: String
    let wine: String
    let rating: RatingDTO
    
    func makeEntity() -> Product {
        return Product(id: id, winery: winery, wine: wine, rating: rating.makeEntity())
    }
}
