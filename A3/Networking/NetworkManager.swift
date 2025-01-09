//
//  NetworkManager.swift

import Alamofire
import Foundation
import UIKit

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    /// Endpoint for dev server
    private let devEndpoint: String = "https://chatdev-wuzwgwv35a-ue.a.run.app/"
    let decoder = JSONDecoder()


    // MARK: - Requests
    
    //create the "get" function
    func fetchPosts(completion: @escaping ([Post]) -> Void){
        //1) specify the endpoint- the URL string where we get the posts from.
        let decoder = JSONDecoder()
        
        //2) create a decoder:
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        //3: create the request
        
        AF.request("\(devEndpoint)/api/posts/", method: .get)
            .validate()
            .responseDecodable(of: [Post].self, decoder: decoder) { response in
                
                // handle the response
                switch response.result {
                case .success(let posts):
                    print("Successfully fetched \(posts.count) posts")
                    completion(posts)
                case .failure(let error):
                    print("Error in NetworkManager.fetchPosts: \(error)")
                }
            }
    }
    


    
    
    //create the function to post a post!
    func addPost(message: String, completion: @escaping (Post) -> Void){
        //specify the end point.
        let endpoint = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/create/"
        
        //define the request body
        let parameters: Parameters = [
            "message" : message,
        ]
        
        // 4. Create a decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Only if needed
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed
        
        // 5. Create the request
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Post.self, decoder: decoder) { response in
            // 5. Handle the response
            switch response.result {
            case .success(let message):
                print("Successfully added post \(message.message)")
                completion(message)
            case .failure(let error):
                print("Error in NetworkManager.addToRoster: \(error)")
                
            }
        }
            
        
    }
    
    func likePost(postID: String, netID: String, completion: @escaping (Bool) -> Void) {
        let endpoint = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/like/"
        
        let parameters: Parameters = [
            "post_id": postID,
            "net_id": netID
        ]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Post.self, decoder: decoder) { response in
                switch response.result {
                case .success:
                    print("Post liked successfully")
                    completion(true)  // Success
                case .failure(let error):
                    print("Error in NetworkManager likePost: \(error)")
                    completion(false) // Failure
                }
            }
    }


    
    
    
    

}
