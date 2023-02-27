//
//  Hero.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-27.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Heading
            Text("Little Lemon")
                .font(.system(size: 48, weight: .medium))
                .foregroundColor(primaryColor2)
            
            HStack {
                VStack(alignment: .leading) {
                    // Sub Heading
                    Text("Chicago")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    // About
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                
                // Image
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(primaryColor1)
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
