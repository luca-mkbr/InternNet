import SwiftUI

struct UserEventView: View {
    @EnvironmentObject var vm: MapEnvironment
    @EnvironmentObject var filterState : FilterStateViewModel
    
    @State private var selectedEvent: Event = Event(id: 1, name: "", date: Date.now, location: "Tysons", category: .anything, latitude: 0, longitude: 0, userIds: [""])
    @State private var isActivitySheetPresented: Bool = false
    @State private var joinedEvent: Bool = true
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            VStack {
                Text("My Events")
                    .font(.title)
                ScrollView {
                    VStack (alignment: .leading, spacing: 20) {
                        if vm.userEvents.count < 1 {
                            Text("You have no events yet.")
                        }
                        ForEach(vm.userEvents) { event in
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    ZStack {
                                        Rectangle()
                                            .fill(event.category.color.opacity(0.1))
                                            .frame(width: 55, height: 55, alignment: .leading)
                                            .cornerRadius(3)
                                            .overlay(
                                                VStack {
                                                    Text("\(event.date.formatted(Date.FormatStyle().month(.abbreviated)))")
                                                        .font(.system(size: 13))
                                                    Text("\(event.date.formatted(Date.FormatStyle().day()))")
                                                }
                                            )
                                    }
                                    .padding(.trailing, 5)
                                    VStack (alignment: .leading) {
                                        Text(event.name)
                                            .bold()
                                            .font(.system(size: 15))
                                        HStack {
                                            Image(systemName: "clock")
                                                .font(.system(size: 13))
                                            Text("\(event.date, style: .time)")
                                                .font(.system(size: 13))
                                        }
                                        HStack {
                                            Image(systemName: "mappin")
                                                .font(.system(size: 13))
                                            Text(event.location)
                                                .font(.system(size: 13))
                                        }

                                    }
                                }
                            }
                            .padding()
                            .frame(width: 350, height: 100, alignment: .leading)
                            .background(.white)
                            .cornerRadius(8)
                            .onTapGesture{
                                print(filterState.state)
                                self.selectedEvent = event
                                self.isActivitySheetPresented.toggle()
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isActivitySheetPresented){
                EventModal(isEventPresented: $isActivitySheetPresented, isJoinedEvent: $joinedEvent, event: $selectedEvent)
            }
        }
    }
}

#Preview {
    UserEventView()
        .environmentObject(MapEnvironment())
}
