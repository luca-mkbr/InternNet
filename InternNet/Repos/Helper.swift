import Foundation

class Helper {
    static func parseAPIResponse<ResponseType: Codable>(data: Data?, response: URLResponse?, error: Error?) -> ResponseType? {
        guard error == nil else {
            print("Error: \(error!)")
            return nil
        }
        guard let data else {
            print("No data found to be displayed.")
            return nil
        }
        
        return parseJSONData(data)
    }
    
    static func parseJSONData<ResponseType: Codable>(_ data: Data) -> ResponseType? {

        var response: ResponseType
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            response = try decoder.decode(ResponseType.self, from: data)
        } catch {
            print("Error parsing the API response: \(error)")
            return nil
        }
        
        return response
    }
}
