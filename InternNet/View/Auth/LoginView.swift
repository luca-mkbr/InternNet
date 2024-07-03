import SwiftUI

class NavigationManager: ObservableObject {
    @Published var showMapView = false
}

struct LoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var filterState : FilterStateViewModel
    @EnvironmentObject var vm : MapEnvironment
    @EnvironmentObject var userData: UserData
    @State var showingAlert: Bool

    var body: some View {
        Spacer()
        VStack(spacing: 20) {
            ZStack(alignment: .leading){
                if email.isEmpty {
                    Text("Email")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 40)
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
                if password.isEmpty{
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 40)
                        
                }
                SecureField("", text: $password)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
                    
            }
            .overlay(RoundedRectangle(cornerRadius:8)
                .stroke(Color.white, lineWidth: 1))
            .padding(.horizontal, 10)
            
            
            Button(action: {
                print("in button")
                if (!userData.login(email, password)) {
                    showingAlert = true
                    print("show alert")
                } else {
                    navigationManager.showMapView = true
                    print("go to app")
                }
            }) {
                
                    Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                    .frame(width: 310, height: 40)
                    .padding(.horizontal, 16)
                    .background(Color.red)
                    .cornerRadius(8)
                    .alert("Invalid email or password", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
            }
            .disabled(email.isEmpty)
            .disabled(password.isEmpty)
        }
        .padding()
        .environmentObject(NavigationManager())
    }
}
