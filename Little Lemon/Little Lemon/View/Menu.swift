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
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Little Lemon")
            
            TextField("Search menu", text: $searchText)
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            NavigationLink(destination: Text(dish.dishDescription ?? "")) {
                                Text("\(dish.title ?? "") : \(dish.price ?? "")")
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
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
//                        guard let _ = exists(name: menuItem.title, context) else {
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
        Menu()
    }
}
