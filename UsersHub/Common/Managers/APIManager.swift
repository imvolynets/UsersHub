import Foundation
import Alamofire

class APIManager {
    static let sharedInstance = APIManager()
    let decoder = JSONDecoder()

    // fetching all users from api
    func fetchingUsers(perPage: Int = 100, sinceId: Int? = nil, handler: @escaping (_ apiData: [User]) -> Void) {
        let url = Constants.APIManager.url
        let parameters: Parameters = [
            "since": sinceId ?? 0,
            "per_page": perPage
        ]
        
        AF.request(url, parameters: parameters).response { resp in
            switch resp.result {
            case .success(let data):
                do {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonData = try self.decoder.decode([User].self, from: data!)
                    handler(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - fetching user's detail info from api
extension APIManager {
    func fetchingUserDetail(userLogin: String, handler: @escaping (Result<UserDetail, Error>) -> Void) {
        let url = Constants.APIManager.urlForDetailInfo
        
        AF.request(url + userLogin).responseData { resp in
            switch resp.result {
            case .success(let data):
                do {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let decodedData = try self.decoder.decode(UserDetail.self, from: data)
                    handler(.success(decodedData))
                    
                } catch {
                    handler(.failure(error))
                }
                
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

//MARK: - fetching user's followers from api
extension APIManager {
    func fetchingUserFollowersImage(userLogin: String, handler: @escaping (_ apiData: [UserFollowers]) -> Void) {
        let url = Constants.APIManager.urlForDetailInfo
        
        AF.request(url + userLogin + "/followers").response { resp in
            switch resp.result {
            case .success(let data):
                do {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonData = try self.decoder.decode([UserFollowers].self, from: data!)
                    handler(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
