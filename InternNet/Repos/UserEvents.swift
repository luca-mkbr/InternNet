import Foundation

class UserEventStore: ObservableObject {
    @Published private(set) var userEventList: [Event] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathExtension("user-events.data")
    }
    
    private func load() -> [Event] {
        do {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return[]
            }
            
            let list = try JSONDecoder().decode([Event].self, from: data)
            return list
        } catch {
            print("Error parsing the local data: \(error)")
            return []
        }
    }
    
    init() {
        let items = self.load()
        self.userEventList.append(contentsOf: items)
    }
    
    func addToList(_ item: Event){
        if (!self.userEventList.contains(where: {$0.id == item.id})) {
            self.userEventList.append(item)
        } else {
            print("already attending \(item.name)")
            return
        }
        self.updateStore()
    }
    
    func contains(_ item: Event) -> Bool {
        if (self.userEventList.contains(where: {$0.id == item.id})){
            return true
        }
        return false
    }
    
    func removeFromEvents(_ item: Event){
        if (!self.userEventList.contains(where: {$0.id == item.id})) {
            print("cannot leave \(item.name), not attending")
            return
        } else {
            userEventList.removeAll(where: {$0.id == item.id})
        }
        self.updateStore()
    }
    
    private func updateStore(){
        guard let data = try? JSONEncoder().encode(self.userEventList) else {
            print("Error encoding event")
            return
        }
        
        guard let outfile = try? Self.fileURL() else {
            print("error opening file")
            return
        }
        
        do {
            try data.write(to: outfile)
            print("Successfully updated file store!")
        } catch {
            print("Error writing data to file")
        }
    }
    
}
