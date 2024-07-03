import Foundation

class UserRepository: ObservableObject {
    @Published private(set) var users = [User]()
    @Published private(set) var id: Int = 1
    @Published private(set) var user: User = User(id: 1, firstName: "", lastName: "", password: "", email: "", company: "", friends: [], eventIDs: [])
    var usersURL: URL? = URL(string: "http://localhost:8080/users")
    var loginURL: URL? = URL(string: "http://localhost:8080/users/login")
    
    init() {
        getUsers()
    }
    
    func login(_ email: String, _ password: String) -> Bool {
        var userRequest = URLRequest(url: loginURL!)
        
        userRequest.httpMethod = "POST"
        userRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["email":email, "password":password])
        userRequest.httpBody = jsonData
        self.id = 0000
        print(email)
        print(password)
        URLSession.shared.dataTask(with: userRequest) { [weak self] (data, response, error) in
            if let incomingId: Int? = HelperTwo.parseAPIResponse(data: data, response: response, error: error) {
                print("print in request \(incomingId!)")
                self?.id = incomingId ?? 0000
            }
        }.resume()
        usleep(9999)
        print("id print before if \(id)")
        if id == 0000 {
            print("this should mean invalid user")
            return false
        } else {
            print("user should be loaded into app context successfully")
            getUserById(id: id)
        }
        return true
    }
    
    func getUsers() {
        if let usersURL {
            URLSession.shared.dataTask(with: usersURL) { (data, response, error ) in
                let incomingUsers: [User]? = HelperTwo.parseAPIResponse(data: data, response: response, error: error)
                DispatchQueue.main.async { [weak self] in
                    self?.users.append(contentsOf: incomingUsers ?? [])
                }
            }.resume()
        }
    }
    
    func getUserById(id: Int) {
        if let usersURL = URL(string: "\(usersURL!.absoluteString)/\(id)") {
            URLSession.shared.dataTask(with: usersURL) { (data, response, error ) in
                let incomingUser: User? = HelperTwo.parseAPIResponse(data: data, response: response, error: error)
                DispatchQueue.main.async { [weak self] in
                    self?.user = incomingUser!
                }
            }.resume()
        }
    }
    
    func createUser(user: User) {
        var userRequest = URLRequest(url: usersURL!)
        userRequest.httpMethod = "POST"
        userRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        let jsonBodyData = try? encoder.encode(user)
        userRequest.httpBody = jsonBodyData
        
        URLSession.shared.dataTask(with: userRequest) { [weak self] (data, response, error) in
            if let incomingUser: User? = HelperTwo.parseAPIResponse(data: data, response: response, error: error) {
                self?.getUsers()
                self?.user = incomingUser!
                
            }
        }.resume()
    }
    
    func updateUser(user: User) {
        if let usersURL = URL(string: "\(usersURL!.absoluteString)/\(user.id)") {
            var userRequest = URLRequest(url: usersURL)
            userRequest.httpMethod = "PUT"
            userRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = JSONEncoder()
            
            let jsonBodyData = try? encoder.encode(user)
            userRequest.httpBody = jsonBodyData
            print(userRequest)
            
            URLSession.shared.dataTask(with: userRequest) { [weak self] (data, response, error) in
                if let incomingUser: User? = HelperTwo.parseAPIResponse(data: data, response: response, error: error) {
                    self?.getUsers()
                    self?.user = incomingUser!
                }
            }.resume()
        }
    }
}
