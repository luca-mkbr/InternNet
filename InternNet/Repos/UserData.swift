import Combine
import Foundation

class UserData: ObservableObject {
    private var userRepository = UserRepository()
    private var subscriptions = Set<AnyCancellable>()
    @Published private(set) var users: [User] = []
    @Published private(set) var user: User = User(id: 1, firstName: "", lastName: "", password: "", email: "", company: "", friends: [], eventIDs: [])
    
    init() {
        self.users = []
        self.user = User(id: 1, firstName: "", lastName: "", password: "", email: "", company: "", friends: [], eventIDs: [])
        
        userRepository.$users.sink { [weak self] items in
            self?.users = items
        }.store(in: &subscriptions)
        
        userRepository.$user.sink { [weak self] items in
            self?.user = items
        }.store(in: &subscriptions)
    }
    
    func createUser(user: User) {
        userRepository.createUser(user: user)
    }
    
    func updateUser(user: User) {
        userRepository.updateUser(user: user)
    }
    
    func login(_ email: String, _ password: String) -> Bool {
        print("passing through userdata")
        return userRepository.login(email, password)
    }
}
