//
//  CheckBox.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-28.
//

import SwiftUI

struct CheckBox: View {
    let item: String
    @Binding var checked: Bool
    
    var body: some View {
        Button(action: {
            checked.toggle()
        }) {
            HStack {
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .font(.system(size: 32))
                    .foregroundColor(primaryColor1)
                Text(item)
            }.padding(.vertical, 5)
        }
        .buttonStyle(.plain)
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(item: "Order statuses", checked: .constant(true))
    }
}
