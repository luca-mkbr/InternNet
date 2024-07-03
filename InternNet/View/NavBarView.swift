import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        TabView {
            NavigationView {
                MapView()
            }
            .tabItem(){
                Image(systemName: "pin")
                Text("Map")
            }
            NavigationView {
                UserEventView()
            }
            .tabItem{
                Image(systemName: "folder.badge.person.crop")
                Text("My Events")
            }
            NavigationView {
                ProfileView()
            }
            .tabItem(){
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

#Preview {
    NavBarView()
}
