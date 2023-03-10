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
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)
            .cornerRadius(8)
            
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
        let viewContext = PersistenceController.shared.container.viewContext
        
        let dish = Dish(context: viewContext)
        dish.title = "Greek Salad"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.price = "10"
        
        dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.category = "starters"
        
        return ItemDetail(dish: dish).environment(
            \.managedObjectContext, viewContext)
    }
}
