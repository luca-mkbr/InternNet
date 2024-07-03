import SwiftUI

struct WhatAreYouFeelingView: View {
    @State private var showMapView : Bool = false
    let gradient = LinearGradient(colors: [Color.white, Color.white],
                                  startPoint: .top, endPoint: .bottom)
    @State private var isAnimating = false
    @State private var animatedText: String = ""
    let titleText = "What are you feeling today?"
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var filterState : FilterStateViewModel
    
    func animateText(at position: Int = 0){
        if position == 0 {
            animatedText = ""
        }
        if position < titleText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                animatedText.append(titleText[position])
                animateText(at: position + 1)
            }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                gradient
                    .ignoresSafeArea()
                VStack{
                    
                    Text(animatedText)
                        .padding(.bottom, 20)
                        .opacity(isAnimating ? 0 : 1)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                
                    NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                        Text("ACTIVE.")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 10)
                    }.simultaneousGesture(TapGesture().onEnded {
                        filterState.updateFilterStateOnly(newState: .active)
                    })
                    .background {
                        Image("activeImage2")
                            .resizable()
                            .opacity(1)
                            .frame(width: 350, height: 150)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                        Text("EAT / DRINK.")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 10)
                    }.simultaneousGesture(TapGesture().onEnded {
                        filterState.updateFilterStateOnly(newState: .eatDrink)
                    })
                    .background {
                        Image("eatDrink")
                            .resizable()
                            .opacity(1)
                            .frame(width: 350, height: 150)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                        Text("ENTERTAINMENT.")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 10)
                    }.simultaneousGesture(TapGesture().onEnded {
                        filterState.updateFilterStateOnly(newState: .entertainment)
                    })
                    .background {
                        Image("entertainment")
                            .resizable()
                            .opacity(1)
                            .frame(width: 350, height: 150)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: NavBarView().navigationBarBackButtonHidden(true)) {
                        Text("ANYTHING.")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 10)
                    }.simultaneousGesture(TapGesture().onEnded {
                        filterState.updateFilterStateOnly(newState: .anything)
                    })
                    .background {
                        Image("anythingImage")
                            .resizable()
                            .opacity(1)
                            .frame(width: 350, height: 150)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                }
                .onAppear {
                    animateText()
                }
            }
        }
        .environmentObject(NavigationManager())
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
#Preview {
    WhatAreYouFeelingView()
}
