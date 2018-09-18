//
//  Article.swift
//  rx_sample
//
//  Created by 石垣駿 on 2018/09/18.
//  Copyright © 2018年 石垣駿. All rights reserved.
//

import Foundation
import ObjectMapper

class Article: Mappable {
    var title: String?
    var user: User?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        user <- map["user"]
    }
}

class User: Mappable {
    var id: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
    }
}
