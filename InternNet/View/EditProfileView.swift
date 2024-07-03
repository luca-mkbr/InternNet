import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var filterState : FilterStateViewModel
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var company: String = ""
    
    var body: some View {
            ZStack() {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 20) {
                    Text("Edit Profile")
                        .font(.title)
                        .bold()
                    
                    Text("First Name")
                    TextField(userData.user.firstName, text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                    
                    Text("Last Name")
                    TextField(userData.user.lastName, text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                    
                    Text("Email")
                    TextField(userData.user.email, text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                    
                    Text("Company")
                    TextField(userData.user.company, text: $company)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                    VStack {
                        
                        HStack {
                            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                                Text("Save Changes")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }.simultaneousGesture(TapGesture().onEnded {
                            var editedUser: User = User(id: userData.user.id, firstName: firstName, lastName: lastName, password: userData.user.password, email: email, company: company, friends: userData.user.friends, eventIDs: userData.user.eventIDs)
                                userData.updateUser(user: editedUser)
                            })
                        }
                        HStack {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(8)
                                .simultaneousGesture(TapGesture().onEnded{
                                    presentationMode.wrappedValue.dismiss()
                                })
                        }
                    }
                    .padding()
                }
        }
            .onAppear {
                firstName = userData.user.firstName
                lastName = userData.user.lastName
                email = userData.user.email
                company = userData.user.company
            }
    }
}

#Preview {
    EditProfileView()
}
