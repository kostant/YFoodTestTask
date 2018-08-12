//
//  Place.swift
//  Eda
//
//  Created by kost ant on 03.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

class Place: Decodable {
    
    let id: Int
    let name: String
    let description: String?
    let imagePath: String
    
    required init(from decoder: Decoder) throws {
        let wrapper = try decoder.container(keyedBy: WrapperKeys.self)
        let values = try wrapper.nestedContainer(keyedBy: CodingKeys.self, forKey: .place)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String?.self, forKey: .description)
        let picture = try values.nestedContainer(keyedBy: PictureKeys.self, forKey: .picture)
        imagePath = try picture.decode(String.self, forKey: .uri)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case picture
    }
    
    enum WrapperKeys: String, CodingKey {
        case place
    }
    
    enum PictureKeys: String, CodingKey {
        case uri
    }
}
