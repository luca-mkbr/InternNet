import SwiftUI

struct OnboardingButtons: View {
    @Binding var onboardingState: Bool
    @Binding var loginState: Bool
    @Binding var signupState: Bool
    var body: some View {
        VStack(spacing: 20){
            
            Spacer()
            HStack {
                Text("InternNet")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {
                onboardingState = false
                loginState = true
                signupState = false
            }){
                Text("Log In")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: 325)
            .background(.red)
            .cornerRadius(8)
            
            Button(action: {
                onboardingState = false
                loginState = false
                signupState = true
            }){
                Text("Sign Up")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.red)
            .fontWeight(.semibold)
            .padding(.vertical, 12)
            .frame(maxWidth: 325)
            .background(Color.white)
            .cornerRadius(8)
            Spacer()
            
        }
    }
}

#Preview {
    OnboardingButtons(onboardingState: .constant(true), loginState: .constant(false), signupState: .constant(false))
}
