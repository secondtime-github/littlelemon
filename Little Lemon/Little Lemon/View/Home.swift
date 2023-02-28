//
//  Home.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI

struct Home: View {
    
    var persistence = PersistenceController.shared
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Menu(selection: $selection)
                .environment(
                    \.managedObjectContext,
                     persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(0)
            
            UserProfile(selection: $selection)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
