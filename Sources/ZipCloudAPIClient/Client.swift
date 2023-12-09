//
//  File.swift
//  
//
//  Created by 柿崎逸 on 2023/12/08.
//

import Entity
import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct ZipCloudAPIClient {
    public var searchAddresses: @Sendable (_ query: String) async throws -> [Result]
}

extension ZipCloudAPIClient: DependencyKey {
    public static let liveValue: Self = {
        return Self(
            searchAddresses: {
                guard let url = URL(
                    string: "https://zipcloud.ibsnet.co.jp/api/search?zipcode=\($0)"
                ) else { return [] }
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let results = try decoder.decode(
                    Address.self,
                    from: data
                ).results
                return results
            }
        )
    }()
}

extension DependencyValues {
    public var zipCloudAPIClient: ZipCloudAPIClient {
        get { self[ZipCloudAPIClient.self] }
        set { self[ZipCloudAPIClient.self] = newValue }
    }
}

extension ZipCloudAPIClient: TestDependencyKey {
    public static let previewValue = Self(
        searchAddresses: { _ in [] }
    )

    public static let testValue = Self(
        searchAddresses: unimplemented("\(Self.self).searchAddresses")
    )
}
