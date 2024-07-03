struct Contact: Identifiable {
    let id = UUID()
    let name: String
}

import SwiftUI
import Combine
import Foundation

struct FriendSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var filterState: FilterStateViewModel
    @EnvironmentObject var userData: UserData

        var body: some View {
            NavigationView {
                VStack {
                    List(userData.users, id: \.self) { contact in
                        Text(contact.firstName + " " + contact.lastName)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Invite Friends")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    EditButton()
                }
                .padding()
            }
        }
}

#Preview {
    FriendSheetView()
        .environmentObject(UserData())
}
