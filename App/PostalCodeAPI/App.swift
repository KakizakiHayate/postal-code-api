//
//  PostalCodeAPIApp.swift
//  PostalCodeAPI
//
//  Created by 柿崎逸 on 2023/12/05.
//

import SwiftUI
import Home
import ComposableArchitecture

@main
struct PostalCodeAPIApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: .init(
                    initialState: Home.State()
                ) {
                    Home() // ここがないとStateやActionが処理されない
                }
            )
        }
    }
}
