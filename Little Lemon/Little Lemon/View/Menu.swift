//
//  Menu.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var categories: Set<Category> = [
        .starter,
        .main,
        .dessert,
        .drink
    ]
    
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
                    .padding([.horizontal, .bottom])
                    .background(primaryColor1)
                }
                
                // Menu Breakdown
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .font(.system(size: 18, weight: .heavy))
                    Spacer()
                }
                .padding([.leading, .top])
                
                HStack {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(action: {
                            if categories.contains(category) {
                                categories.remove(category)
                            } else {
                                categories.insert(category)
                            }
                        }) {
                            Text(category.rawValue)
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(
                                    categories.contains(category)
                                    ? .white
                                    : primaryColor1)
                                .padding(8)
                                .background(
                                    categories.contains(category)
                                    ? primaryColor1
                                    : .gray.opacity(0.2))
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
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: ItemDetail(dish: dish)) {
                            FoodMenuItem(dish: dish)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchDataFromServer(parseDate)
        }
    }
    
    func parseDate(data: Data) {
        do {
            let responseData = try JSONDecoder().decode(MenuList.self, from: data)
            let menuItems = responseData.menu
            
            for menu in menuItems {
                insertDataIfNeeded(menu: menu)
            }
            
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    func insertDataIfNeeded(menu: MenuItem) {
        let fetchRequest = NSFetchRequest<Dish>(entityName: "Dish")
        fetchRequest.predicate = NSPredicate(format: "title == %@", menu.title)
        let results = try? viewContext.fetch(fetchRequest)
        
        if let _ = results?.first {
            // data already exists, do nothing
        } else {
            // insert data
            let dish = Dish(context: viewContext)
            dish.title = menu.title
            dish.image = menu.image
            dish.price = menu.price
            
            dish.dishDescription = menu.description
            dish.category = menu.category
            
            try? viewContext.save()
        }
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
        // category
        let status = categories.map({ $0.rawValue.lowercased() })
        let categoryPredicate = NSPredicate(format: "category IN[cd] %@", status)
        
        // search bar
        let searchPredicate = searchText.isEmpty
        ? NSPredicate(value: true)
        : NSPredicate(format: "title CONTAINS[cd] %@", searchText)

        return NSCompoundPredicate(type: .and, subpredicates: [categoryPredicate, searchPredicate])
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(selection: .constant(0)).environment(
            \.managedObjectContext,
             PersistenceController.shared.container.viewContext)
    }
}
