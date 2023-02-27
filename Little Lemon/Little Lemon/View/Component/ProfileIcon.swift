//
//  ProfileIcon.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-27.
//

import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Image("profile-image-placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

struct ProfileIcon_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIcon()
    }
}
