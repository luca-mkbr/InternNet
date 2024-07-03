import SwiftUI

struct SignUpView: View {
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var email : String = ""
    @State private var company: String = ""
    @State private var password : String = ""
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var filterState : FilterStateViewModel
    
    var body: some View{
        VStack(spacing: 20){
            ZStack(alignment: .leading){
                if firstName.isEmpty {
                    Text("First Name")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: 40)
                }
                TextField("", text: $firstName)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            
            ZStack(alignment: .leading){
                if lastName.isEmpty {
                    Text("Last Name")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: 40)
                }
                TextField("", text: $lastName)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            ZStack(alignment: .leading){
                if company.isEmpty {
                    Text("Company")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height:40)
                }
                TextField("", text: $company)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            ZStack(alignment: .leading){
                if email.isEmpty {
                    Text("Email")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height:40)
                }
                TextField("", text: $email)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            ZStack(alignment: .leading){
                if password.isEmpty {
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: 40)
                }
                SecureField("", text: $password)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            Button(action: {

            }) {
                NavigationLink(destination: WhatAreYouFeelingView().navigationBarBackButtonHidden(true)) {
                Text("Create Account")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
                }.simultaneousGesture(TapGesture().onEnded{
                    let newUser = User(id: 0, firstName: firstName, lastName: lastName, password: password, email: email, company: company, friends: [], eventIDs: [])
                    userData.createUser(user: newUser)
                    print("adding user")
                })
            }
            .padding(.horizontal, 20)
        }
    }
}
