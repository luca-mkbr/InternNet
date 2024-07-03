import Foundation

class HelperTwo {
    static func parseAPIResponse<ResponseType: Codable>(data: Data?, response: URLResponse?, error: Error?) -> ResponseType? {
        guard error == nil else {
            print("Error: \(error!)")
            return nil
        }
        guard let data = data else {
            print("No data found to be displayed.")
            return nil
        }
        
        return parseJSONData(data)
    }
    
    static func parseJSONData<ResponseType: Codable>(_ data: Data) -> ResponseType? {
        var response: ResponseType
        do {
            response = try JSONDecoder().decode(ResponseType.self, from: data)

        } catch {
            print("Error parsing the API response: \(error)")
            return nil
        }
        
        return response
    }
}
