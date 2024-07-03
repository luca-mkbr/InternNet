//  https://betterprogramming.pub/how-to-create-a-looping-video-background-in-swiftui-3-0-b4844553880d

import SwiftUI

struct OnboardingView: View {
    @State private var onboardingState:Bool = true
    @State private var loginState:Bool = false
    @State private var signupState:Bool = false
    var body: some View{
        NavigationView {
            GeometryReader{ geo in
                ZStack{
                    PlayerView()
                        .aspectRatio(9/16, contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height+200)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 1)
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    if onboardingState && !loginState && !signupState {
                        OnboardingButtons(onboardingState: $onboardingState, loginState: $loginState, signupState: $signupState)
                    }
                    else if !onboardingState && loginState && !signupState{
                        LoginView(showingAlert: false)
                    }
                    else if !onboardingState && !loginState && signupState{
                        SignUpView()
                    }
                }
            }
        }
    }
}


#Preview {
    OnboardingView()
}

