//
//  FetchData.swift
//  Little Lemon
//
//  Created by TEKI HOU on 2023-02-28.
//

import Foundation

func fetchDataFromServer( _ doSomething: @escaping (Data) -> Void) {
    guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else { return }
    
    let session = URLSession.shared
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Invalid response")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        doSomething(data)
    }
    
    task.resume()
}
