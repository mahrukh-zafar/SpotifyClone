//
//  Network Manager.swift
//  Spotify-Clone
//
//  Created by Dev on 06/05/2024.
//

import Foundation
import Alamofire

struct NetworkManager{
    
    
    func getImage(imageUrl : String, onComplete: @escaping (Data) -> Void) {
        
        // Step 1: Create a URL object from the URL string
        guard let url = URL(string: imageUrl) else {
            print("Invalid URL")
            return
        }

        // Step 2: Create a URLSession instance
        let session = URLSession.shared

        // Step 3: Create a data task
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Ensure that we have received a successful response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            // Ensure that we have received data
            guard let responseData = data else {
                print("No data received")
                return
            }
            
           
            // Step 4: Handle the received data
            // You can parse the data or use it as needed

            onComplete(responseData)
        }

        // Step 4: Resume the data task
        task.resume()

    }
}
