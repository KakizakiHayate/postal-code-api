//
//  File.swift
//  
//
//  Created by 柿崎逸 on 2023/12/06.
//

import Foundation

public struct Address: Codable {
    public let results: [Result]
    public let status: Int

    public init(results: [Result], status: Int) {
        self.results = results
        self.status = status
    }
}
