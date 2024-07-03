import SwiftUI
import Combine

class FilterStateViewModel: ObservableObject {
    @Published var state: FilterState = .anything
    @Published var fromDate: Date = Date.now
    @Published var toDate: Date = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    
    func updateFilterState(newState: FilterState, newFrom: Date, newTo: Date){
        self.fromDate = newFrom
        self.toDate = newTo
        self.state = newState
    }
    func updateFilterStateOnly(newState: FilterState){
        self.state = newState
    }
}
