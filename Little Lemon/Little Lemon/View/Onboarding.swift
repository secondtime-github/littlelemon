//
//  Onboarding.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-20.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                //                    EmptyView()
                //                }
                
                Image("Logo")
                
                Hero()
                
                VStack {
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                    TextField("Email", text: $email)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                    
                    Button(action: {
                        if !firstName.isEmpty && !lastName.isEmpty && isValid(email: email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            
                            isLoggedIn = true
                        }
                    }) {
                        Text("Register")
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(primaryColor2))
                    }
                    .navigationDestination(isPresented: $isLoggedIn) {
                        Home()
                    }
                }
                .padding()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
