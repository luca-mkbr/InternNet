import SwiftUI
import Combine

class EventStore: ObservableObject {
    @Published private(set) var eventItems = [Event]()
    
    let eventUrl = "http://localhost:8080/events"
    
    init(){
        loadEventItems()
    }
    
    func loadEventItems(){
        if let eventUrl = URL(string: eventUrl){
            URLSession.shared.dataTask(with: eventUrl) { (data, response, error ) in
                let items: [Event]? = Helper.parseAPIResponse(data: data, response: response, error: error)
                DispatchQueue.main.async { [weak self] in
                    self?.eventItems.append(contentsOf: items ?? [])
                }
            }.resume()
        }
    }
    
    func addEvent(_ item: Event){
        let eUrl = URL(string: eventUrl)
        var eventRequest = URLRequest(url: eUrl!)
        eventRequest.httpMethod = "POST"
        eventRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        
        let jsonBodyData = try? encoder.encode(item)
        eventRequest.httpBody = jsonBodyData
        
        
        URLSession.shared.dataTask(with: eventRequest) { [weak self] (data, response, error) in
            if let _: Event? = Helper.parseAPIResponse(data: data, response: response, error: error) {
                self?.loadEventItems()
            }
        }.resume()
    }
}
