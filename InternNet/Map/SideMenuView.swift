import SwiftUI
import MapKit

struct SideMenuView: View {
    @State private var showFilterModal: Bool = false
    @State private var showAddEventModal: Bool = false
    @State private var isSheetPresented: Bool = false
    @State private var searchResults = [SearchResult]()
    @EnvironmentObject var filterState : FilterStateViewModel
        
    var body: some View {
        VStack {
            Button ( action: {
                self.isSheetPresented = true
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(5)
            }
            )
            .sheet(isPresented: $isSheetPresented) {
                SheetView(searchResults: $searchResults)
            }
            
            
            Button ( action: {
                self.showAddEventModal = true
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(5)
            })
            .sheet(isPresented: self.$showAddEventModal){
                AddEventModalView(isEventAddPresented: $showAddEventModal)
            }
            
            
            Button ( action: {
                self.showFilterModal = true
            }, label: {
                Image(systemName: "square.3.layers.3d")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(5)
            })
            .sheet(isPresented: self.$showFilterModal){
                FilterModalView(isPresented: $showFilterModal, catSelect: filterState.state, selectedDateFrom: filterState.fromDate, selectedDateTo: filterState.toDate)
            }

        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .systemBackground))
                .tint(Color(uiColor: .secondaryLabel))
        }
    }
}

#Preview {
    SideMenuView()
}
