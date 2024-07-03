import Foundation
import Combine

class MapEnvironment: ObservableObject{
    private var eventStorage = EventStore()
    private var subscriptions = Set<AnyCancellable>()
    @Published private(set) var eventData: Events = []
    
    var userEventStore = UserEventStore()
    @Published private(set) var userEvents: Events = []
        
    init() {
        self.eventData = []
        
        eventStorage.$eventItems.sink { [weak self] items in
            self?.eventData = items
            print(items)
        }.store(in: &subscriptions)
        
        userEventStore.$userEventList.sink { [weak self] items in
            self?.userEvents = items
        }.store(in: &subscriptions)
    }
    
    func addToUserEvents(event: Event){
        userEventStore.addToList(event)
    }
    
    func userJoinedEvent(event: Event) -> Bool{
        return userEventStore.contains(event)
    }
    
    func createEvent(eventItem: Event){
        print(eventItem)
        eventStorage.addEvent(eventItem)
    }
    
    func removeUserEvent(eventItem: Event){
        userEventStore.removeFromEvents(eventItem)
    }
}
