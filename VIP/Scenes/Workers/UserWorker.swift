import Foundation

class UserWorker {
    public func getCep(
        cep: String,
        completion: @escaping(_ response: CepResponse?) -> Void) {
        let url = URL(string: "https://viacep.com.br/ws/\(cep)/json")
        
        if let url = url {
            var request = URLRequest(url: url,timeoutInterval: Double.infinity)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let cep = try? JSONDecoder().decode(CepResponse.self, from: data)
                guard let cep = cep else {
                    completion(nil)
                    return
                }
                completion(cep)
            }
            task.resume()
        }
    }
}
