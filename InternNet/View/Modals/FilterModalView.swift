import SwiftUI

struct FilterModalView: View {
    @State private var activityText: String = ""

    
    @State private var locationText: String = ""
    @State private var showDatePicker: Bool = false
    
    @EnvironmentObject var filterStateChanger : FilterStateViewModel
    @Binding var isPresented: Bool
    
    @State var catSelect : FilterState
    @State var selectedDateFrom: Date
    @State var selectedDateTo: Date
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Filter Activities")
                .font(.headline)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack {
                HStack {
                    Text("From")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    DatePicker("", selection: $selectedDateFrom, displayedComponents: .date)
                }
                HStack {
                    Text("To")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    DatePicker("", selection: $selectedDateTo, displayedComponents: .date)
                }
            }
            
            HStack {
                Text("Choose Category")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
                Picker("\(catSelect)", selection: $catSelect) {
                    ForEach(FilterState.allCases, id: \.self) { state in
                        Text("\(state.selectedCategory)")
                            .tag(state)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: catSelect){ newVal, _ in
                    catSelect = newVal
                }
            }
            
            HStack {
                Spacer()
                Button("Apply Filters") {
                    // action for apply filter
                    if (selectedDateFrom > selectedDateTo){
                        isAlertPresented = true
                    } else {
                        isAlertPresented = false
                        filterStateChanger.updateFilterState(newState: catSelect, newFrom: selectedDateFrom, newTo: selectedDateTo)
                        isPresented = false
                    }
                }
                .alert("Date mismatch. Adjust dates to resubmit", isPresented: $isAlertPresented){
                    Button("OK", role: .cancel) {}
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                Spacer()
                Button("Close") {
                    selectedDateTo = filterStateChanger.toDate
                    selectedDateFrom = filterStateChanger.fromDate
                    catSelect = filterStateChanger.state
                    isPresented = false
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                Spacer()
            }
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}


//#Preview {
//    FilterModalView()
//}

