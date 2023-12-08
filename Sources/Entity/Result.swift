//
//  Result.swift
//
//
//  Created by 柿崎逸 on 2023/12/07.
//

import Foundation

public struct Result: Codable, Equatable {
    public let address1: String
    public let address2: String
    public let address3: String
    public let kana1: String
    public let kana2: String
    public let kana3: String

    public init(
        address1: String,
        address2: String,
        address3: String,
        kana1: String,
        kana2: String,
        kana3: String
    ) {
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.kana1 = kana1
        self.kana2 = kana2
        self.kana3 = kana3
    }
}
