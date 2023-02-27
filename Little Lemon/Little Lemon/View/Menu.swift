//
//  Menu.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    @Binding var selection: Int
    
    var body: some View {
        VStack {
            // Navigation Bar
            HStack {
                Color(.black)
                    .opacity(0)
                    .frame(width: 50, height: 50)
                Spacer()
                Image("Logo")
                Spacer()
                ProfileIcon().onTapGesture { selection = 1 }
            }
            .padding(.horizontal)
            
            ScrollView {
                
                // Hero Section
                VStack(spacing: 0) {
                    Hero()
                    // Search
                    TextField(text: $searchText) {
                        Text(Image(systemName: "magnifyingglass"))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                    )
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(primaryColor1)
                }
                
                // Menu Breakdown
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .font(.system(size: 18, weight: .heavy))
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                
                HStack {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(action: {}) {
                            Text(category.rawValue)
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(primaryColor1)
                                .padding(8)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(16)
                                .padding(8)
                        }
                    }
                }
                Divider()
                
                // Menu Items
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    //List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: ItemDetail(dish: dish)) {
                            FoodMenuItem(dish: dish)
                        }
                    }
                    //}
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlStr = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlStr)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data = data {
                let decoder = JSONDecoder()
                let fullMenu = try? decoder.decode(MenuList.self, from: data)
                if let menuItems = fullMenu?.menu {
                    for menuItem in menuItems {
                        //                        guard let _ = PersistenceController.shared.exists(title: menuItem.title) else {
                        //                            continue
                        //                        }
                        
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        
                        dish.dishDescription = menuItem.description
                        dish.category = menuItem.category
                    }
                    try? viewContext.save()
                }
            }
        }
        
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(selection: .constant(0))
    }
}
