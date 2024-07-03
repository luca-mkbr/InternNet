import SwiftUI

struct WhatYouFeelingTwo: View {
    @State private var showMapView : Bool = false
    
    var body: some View {
        NavigationStack {
            Text("What are you feeling today?")
                .animation(.bouncy)
                .padding(.bottom, 50)
                .font(.system(.title, design: .serif))
            
            NavigationLink(destination: NavBarView()) {
                Text("ACTIVE.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .frame(width: 330, height: 140)
                    .background(.black)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
            
            NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                Text("EAT / DRINK.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .frame(width: 330, height: 140)
                    .background(.black)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
            
            NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                Text("ENTERTAINMENT.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .frame(width: 330, height: 140)
                    .background(.black)
                    .cornerRadius(10)
                    .shadow(color: .gray , radius:2)
            }
            .padding(.bottom, 10)
            
            NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                Text("ANYTHING.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .frame(width: 330, height: 140)
                    .background(.black)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    WhatYouFeelingTwo()
}
