//
//  MenuItem.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let price: String
    
    let description: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case price = "price"
        
        case description = "description"
        case category = "category"
    }
}
