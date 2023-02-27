//
//  UserProfile.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var selection: Int
    
    @State var firstNameText = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastNameText = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var emailText = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @State var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @State var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @State var specialOffer = UserDefaults.standard.bool(forKey: kSpecialOffer)
    @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    var body: some View {
        VStack {
            // Navigation Bar
            HStack {
                Button(action: {
                    selection = 0
                }) {
                    Image(systemName: "arrow.backward.circle.fill")
                        .font(.system(size: 42))
                        .foregroundColor(primaryColor1)
                }
                Spacer()
                Image("Logo")
                Spacer()
                ProfileIcon()
            }
            .padding(.horizontal)
            
            ScrollView {
                // Personal information
                VStack(alignment: .leading) {
                    Text("Personal information")
                        .font(.system(size: 18, weight: .bold))
                    
                    // Avatar
                    HStack(spacing: 20) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        Button(action: {}) {
                            Text("Change")
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(primaryColor1))
                        }
                        
                        Button(action: {}) {
                            Text("Remove")
                                .foregroundColor(primaryColor1)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(primaryColor1))
                        }
                    }
                    
                    TextField("First Name", text: $firstNameText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                    TextField("Last Name", text: $lastNameText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                    TextField("Email", text: $emailText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                }.padding()
                // Email notifications
                VStack(alignment: .leading) {
                    Text("Email notifications")
                        .font(.system(size: 18, weight: .bold))
                    
                    checkItem(item: "Order statuses", checked: $orderStatuses)
                    checkItem(item: "Password changes", checked: $passwordChanges)
                    checkItem(item: "Special offers", checked: $specialOffer)
                    checkItem(item: "Newsletter", checked: $newsletter)
                    
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                        
                        UserDefaults.standard.set(false, forKey: kOrderStatuses)
                        UserDefaults.standard.set(false, forKey: kPasswordChanges)
                        UserDefaults.standard.set(false, forKey: kSpecialOffer)
                        UserDefaults.standard.set(false, forKey: kNewsletter)
                        
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("Log out")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(primaryColor2))
                    }
                }.padding()
                
                HStack {
                    Button(action: { discardChange() }) {
                        Text("Discard Changes")
                            .foregroundColor(primaryColor1)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(primaryColor1))
                    }
                    
                    Button(action: { saveChange() }) {
                        Text("Save Changes")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(primaryColor1))
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
        }
    }
    
    func discardChange() {
        firstNameText = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        lastNameText = UserDefaults.standard.string(forKey: kLastName) ?? ""
        emailText = UserDefaults.standard.string(forKey: kEmail) ?? ""
        
        orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
        passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
        specialOffer = UserDefaults.standard.bool(forKey: kSpecialOffer)
        newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    }
    
    func saveChange() {
        UserDefaults.standard.set(firstNameText, forKey: kFirstName)
        UserDefaults.standard.set(lastNameText, forKey: kLastName)
        UserDefaults.standard.set(emailText, forKey: kEmail)
        
        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
        UserDefaults.standard.set(specialOffer, forKey: kSpecialOffer)
        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaults.standard.set("firstName", forKey: kFirstName)
        UserDefaults.standard.set("lastName", forKey: kLastName)
        UserDefaults.standard.set("email", forKey: kEmail)
        
        return UserProfile(selection: .constant(1))
    }
}

struct checkItem: View {
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
