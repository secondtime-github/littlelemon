//
//  FoodMenuItem.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-27.
//

import SwiftUI

struct FoodMenuItem: View {
    let dish: Dish
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(dish.title ?? "")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.black)
                    Text(dish.dishDescription ?? "")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black.opacity(0.4))
                    Text("$" + (dish.price ?? ""))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black.opacity(0.5))
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
            }
            .padding()
            Divider()
        }
    }
}

struct FoodMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        
        let dish = Dish(context: viewContext)
        dish.title = "Greek Salad"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.price = "10"
        
        dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.category = "starters"
        
        return FoodMenuItem(dish: dish).environment(
            \.managedObjectContext, viewContext)
    }
}
