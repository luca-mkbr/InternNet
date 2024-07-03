import SwiftUI
import MapKit
import Combine
import Foundation

let startPosition = MapCameraPosition.region( MKCoordinateRegion( center: CLLocationCoordinate2D(latitude: 38.9262512372886, longitude: -77.21222261210873), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.03) ))

struct MapEvent: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let eventType: FilterState
}

struct MapView: View {
    @State private var searchResults = [SearchResult]()

    @State private var isSheetPresented: Bool = false
    @State private var scene: MKLookAroundScene?
    @State private var showFilterModal: Bool = false
    @State private var showAddEventModal: Bool = false
    @EnvironmentObject var filterState : FilterStateViewModel
    
    @State private var isActivitySheetPresented: Bool = false
        
    @EnvironmentObject var eventStore: EventStore
    @State private var selectedEvent: Event = Event(id: 1, name: "", date: Date.now, location: "Tysons", category: .anything, latitude: 0, longitude: 0, userIds: [""])
    
    @EnvironmentObject var vm: MapEnvironment
    
    @State private var isJoinedEvent: Bool = false
    
    let calendar = Calendar.current
    
    func dateOnly(from date: Date) -> Date? {
        let dateComp = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: dateComp)
    }
        
    
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            Map(initialPosition: startPosition) {
                ForEach(vm.eventData){ event in
                    if let fromDateOnly = dateOnly(from: filterState.fromDate) {
                        if let toDateOnly = dateOnly(from: filterState.toDate) {
                            if let compareDateOnly = dateOnly(from: event.date) {
                                if (filterState.state == .anything || event.category == filterState.state) && (compareDateOnly >= fromDateOnly) && (compareDateOnly <= toDateOnly) {
                                    Annotation(event.name, coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)){
                                        ZStack {
                                            VStack(spacing:0){
                                                Image(systemName: event.category.sfSymbol)
                                                    .font(.title)
                                                    .foregroundColor(event.category.color)
                                                    .background(Color.white)
                                                    .cornerRadius(500)
                                                Image(systemName: "arrowtriangle.down.fill")
                                                  .font(.caption)
                                                  .foregroundColor(event.category.color)
                                                  .offset(x: 0, y: -5)
                                            }
                                        }
                                        .onTapGesture{
                                            self.isJoinedEvent = vm.userJoinedEvent(event: event)
                                            self.selectedEvent = event
                                            self.isActivitySheetPresented.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            SideMenuView()
                .padding(.trailing,20)
                .padding(.bottom, 520)
            FilterMenuBar()
                .padding(.bottom, 670)
                .padding(.trailing, 20)
                .padding(.leading, 20)

        }
        .sheet(isPresented: $isActivitySheetPresented){
            EventModal(isEventPresented: $isActivitySheetPresented, isJoinedEvent: $isJoinedEvent, event: $selectedEvent)
        }
    }
    
    private func fetchScene(for coordinate: CLLocationCoordinate2D) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await lookAroundScene.scene
    }
    
}

#Preview {
    MapView()
        .environmentObject(MapEnvironment())
}
