import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var userData: UserData
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var company: String = ""

    var body: some View {
        NavigationView {
            ZStack() {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 20) {
                    Text("Profile")
                        .font(.title)
                        .bold()
                                 
                    Text("First Name")
                    TextField(userData.user.firstName, text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                        .disabled(true)
                    
                    Text("Last Name")
                    TextField(userData.user.lastName, text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                        .disabled(true)
                                 
                    Text("Email")
                    TextField(userData.user.email, text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                        .disabled(true)
                    
                    Text("Company")
                    TextField(userData.user.company, text: $company)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                        .disabled(true)
                    
                    HStack {
                        
                        NavigationLink(destination:
                                        EditProfileView()) {
                            Text("Edit Profile")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination:
                                        OnboardingView().navigationBarBackButtonHidden(true)) {
                            Text("Logout")
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        /* TODO: Work on logout
                        .simultaneousGesture(TapGesture().onEnded{
                            navigationManager.showMapView = false
                        })*/
                    }
                    .padding()
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
