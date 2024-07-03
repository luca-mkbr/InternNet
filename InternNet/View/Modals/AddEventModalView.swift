import SwiftUI
import MapKit


struct AddEventModalView: View {
    
    // current filter state
    @EnvironmentObject var filterState : FilterStateViewModel
    
    // Event variables
    @EnvironmentObject var eventStore: EventStore
    @State private var eventName: String = ""
    @State private var eventDate: Date = Date.now
    @State private var eventCategory: FilterState = .anything
    @State private var eventGroupSize: Int = 0
    @State private var latitude: Double? = 0.0
    @State private var longitude: Double? = 0.0
    @State private var location: String = ""

    // sheets to present
    @State private var showFriendsSheet = false
    @Binding var isEventAddPresented: Bool
    @State private var isSearchPresented: Bool = false
    
    // search sheet variables
    @State private var searchResults = [SearchResult]()
    @State private var locationService = LocationService(completer: .init())
    
    @EnvironmentObject var vm: MapEnvironment

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                // Location input
                Text("Create an Event").font(.system(size: 30))
                
                // change for sheet
                VStack {
                    HStack {
                        TextField("Event Name", text: $eventName)
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Location", text: $location)
                            .autocorrectionDisabled()
                            .onTapGesture{
                                self.isSearchPresented = true
                            }
                            .onSubmit {
                                Task {
                                    searchResults = (try? await locationService.search(with: location)) ?? []
                                }
                            }
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .sheet(isPresented: $isSearchPresented){
                        SearchAddEvent(searchResults: $searchResults, message: $location, isPresented: $isSearchPresented, title: $location, latitude: $latitude, longitude: $longitude)
                    }
                }
                                
                DatePicker("Date", selection: $eventDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .cornerRadius(8)
                    .labelsHidden()
                                
                List {
                    
                    Picker("Activity Type", selection: $eventCategory) {
                        ForEach(FilterState.allCases, id: \.self){
                            state in
                            Text("\(state.selectedCategory)")
                                .tag(state)
                        }
                    }
                    
                    
                    Picker("Number of people", selection: $eventGroupSize) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .frame(maxHeight: 2100)
                
                Button(action: {
                    // Submit sign up data
                    showFriendsSheet.toggle()

                }) {
                    Text("Invite Friends")
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .cornerRadius(8)
                } .sheet(isPresented: $showFriendsSheet) {
                    FriendSheetView()
                }
                
                Button(action: {
                    
                    if let latitude {
                        if let longitude {
                            let newEvent = Event(id: Int(arc4random()), name: eventName, date: eventDate, location: location, category: eventCategory, latitude: latitude, longitude: longitude, people: eventGroupSize, userIds:["john"])
                            vm.createEvent(eventItem: newEvent)
                        }
                    }
                    
                    eventName = ""
                    eventDate = Date.now
                    location = ""
                    eventCategory = .anything
                    
                    isEventAddPresented = false

                }) {
                    Text("Create Event")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            .padding()
        }.frame(maxHeight: 420)
    }
}

//#Preview {
//    AddEventModalView( isEventAddPresented: Binding.constant(true))
//}
