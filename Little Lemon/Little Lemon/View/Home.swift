//
//  Home.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI

struct Home: View {
    
    var persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                Label("Menu", systemImage: "list.dash")
            }
            UserProfile()
                .tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
