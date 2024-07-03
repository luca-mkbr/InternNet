import SwiftUI


struct ContentView: View {
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var filterState = FilterStateViewModel()
    @StateObject var vm: MapEnvironment = MapEnvironment()
    
    let eventStore = EventStore()
    @StateObject private var userManager = UserData()
    
    var body: some View {
        NavigationStack {
            OnboardingView()
                .navigationDestination(isPresented: $navigationManager.showMapView) {
                    WhatAreYouFeelingView().navigationBarBackButtonHidden(true)
                }
                .environmentObject(filterState)

        }
        .environmentObject(navigationManager)
        .environmentObject(filterState)
        .environmentObject(userManager)
        .environmentObject(eventStore)
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
