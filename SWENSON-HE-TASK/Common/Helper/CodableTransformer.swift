//
//  CodableTransformer.swift
//  RequestS
//
//  Created by Macbook on 9/7/19.
//  Copyright © 2019 OrientedEgy. All rights reserved.
//

import Foundation

protocol CodableTransforming {
     func encodeObject<T: Codable>(from model: T) -> Data?
     func decodeObject<T: Codable>(from json: Data,to model: T.Type) -> T?
}

struct CodableTransformer: CodableTransforming{
    
    func encodeObject<T: Codable>(from model: T) -> Data?{
        let jsonEncoder = JSONEncoder()
        let encodedModel = try? jsonEncoder.encode(model)
        return encodedModel
    }
    
    func decodeObject<T: Codable>(from json: Data,to model: T.Type) -> T?{
        let jsonDecoder = JSONDecoder()
        let decodedModel = try? jsonDecoder.decode(model, from: json)
        return decodedModel
    }
    
    
}
