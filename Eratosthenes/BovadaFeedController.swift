//
//  BovadaFeedController.swift
//  Eratosthenes
//
//  Created by doug harper on 9/26/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import Foundation
import UIKit

/*: ## JSON Feeds Bovada
 MMA -> http://sportsfeeds.bovada.lv/v1/feed?clientId=1556643&categoryCodes=1201&language=en
 Politics -> http://sportsfeeds.bovada.lv/v1/feed?clientId=1556643&categoryCodes=22888&language=en
 */

struct Politics: Decodable {
  let id: Int?
}

class BovadaFeedController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonString: String = "http://sportsfeeds.bovada.lv/v1/feed?clientId=1556643&categoryCodes=22888&language=en"
    guard let url = URL(string: jsonString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for err
      // could check for response status 200
      guard let data = data else { return }
      
//      let dataAsString = String(data: data, encoding: .utf8)
//      print(dataAsString ?? "Data is not loading")
      
      do {
        let politicalEvents = try JSONDecoder().decode(Politics.self, from: data)
        print(politicalEvents.id ?? "no data found")
      } catch let jsonErr {
        print("error decoding JSON: ", jsonErr)
      }
      
      }.resume()
    
  }
  
}
