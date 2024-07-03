import SwiftUI
import MapKit

struct SearchAddEvent: View {
    @State private var locationService = LocationService(completer: .init())
    @Binding var searchResults: [SearchResult]
    @EnvironmentObject var filterState : FilterStateViewModel
    
    @Binding var message : String
    @State var placeHolder: String = "Initial Text"
    
    @Binding var isPresented: Bool
    
    @Binding var title : String
    @Binding var latitude: Double?
    @Binding var longitude: Double?
    
    
    var body: some View {
        VStack {
            List {
                ForEach(locationService.completions) { completion in
                    VStack {
                        Button(action: { didTapOnCompletion(completion) }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(completion.title)
                                    .font(.headline)
                                    .fontDesign(.rounded)
                                Text(completion.subTitle)
                            }
                        }
                        Button(action: {
                            // add func for populating search here
                            title = completion.title
                            latitude = completion.latitude
                            longitude = completion.longitude
                            isPresented = false
                        }) {
                            Text("Choose Location")
                        }
                        .padding(7)
                        .buttonStyle(.bordered)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: message) {
            locationService.update(queryFragment: message)
        }
        .padding()
        .presentationDetents([.height(300), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
    }
}

struct TextFieldBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}
