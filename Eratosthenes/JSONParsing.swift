//
//  File.swift
//  Eratosthenes
//
//  Created by doug harper on 9/25/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import UIKit

class JSONParsing: UIViewController {
  // http://api.letsbuildthatapp.com/jsondecodable/course
  // This guy ⬇︎ returns an array of courses
  // https://api.letsbuildthatapp.com/jsondecodable/course
  // Even more complicated JSON ⬇︎
  // https://api.letsbuildthatapp.com/jsondecodable/website_description
  // Missing Data in JSON
  // https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields
  
  // Create a model object that reflects what our JSON is
  struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
  }
  
  struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
  }
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonURLString: String = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
    guard let url = URL(string: jsonURLString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for err
      // could check for response status 200
      
      guard let data = data else { return }
      
      //      let dataAsString = String(data: data, encoding: .utf8)
      //      print(dataAsString)
      do {
        let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
        print("\(websiteDescription.name): \(websiteDescription.description) \n Course: \(websiteDescription.courses[0].name ?? "")")
        //        let courses = try
        //          JSONDecoder().decode([Course].self, from: data)
        //        print(courses)
        
      } catch let jsonErr {
        print("error deserializing json: ", jsonErr)
      }
      
      }.resume()
    
    //    let myCourse = Course(id: 1, name: "my course", link: "some link", imageUrl: "some image URL")
    //    print(myCourse)
  
  }
  
}

