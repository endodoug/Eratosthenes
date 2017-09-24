//
//  ViewController.swift
//  Eratosthenes
//
//  Created by doug harper on 9/18/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // http://api.letsbuildthatapp.com/jsondecodable/course
  
  struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    
//    init(json: [String: Any]) {
//      id = json["id"] as? Int ?? -1
//      name = json["name"] as? String ?? ""
//      link = json["link"] as? String ?? ""
//      imageUrl = json["imageUrl"] as? String ?? ""
//    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonURLString: String = "https://api.letsbuildthatapp.com/jsondecodable/course"
    guard let url = URL(string: jsonURLString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for err
      // could check for response status 200
      
      guard let data = data else { return }
      
//      let dataAsString = String(data: data, encoding: .utf8)
//      print(dataAsString)
      do {
        
        let course = try
          JSONDecoder().decode(Course.self, from: data)
        print(course.name)
        
      } catch let jsonErr {
        print("error deserializing json: ", jsonErr)
      }
      
    }.resume()
    
    
//    let myCourse = Course(id: 1, name: "my course", link: "some link", imageURL: "some image URL")
//    print(myCourse)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

