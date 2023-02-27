//
//  ItemDetail.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-27.
//

import SwiftUI

struct ItemDetail: View {
    let dish: Dish
    
    var body: some View {
        VStack {
            Text(dish.title ?? "")
                .font(.system(size: 48, weight: .heavy))
                .foregroundColor(.black)
            
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)
            
            HStack {
                Text("$" + (dish.price ?? ""))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                    .padding()
                
                Spacer()
                
                Text(dish.category ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                    .padding()
            }
            
            
            Text(dish.dishDescription ?? "")
                .multilineTextAlignment(.leading)
                .foregroundColor(.black.opacity(0.5))
                .padding()
        }
        .padding()
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(dish: Dish())
    }
}
