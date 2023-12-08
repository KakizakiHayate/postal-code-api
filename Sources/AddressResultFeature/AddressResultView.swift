//
//  SwiftUIView.swift
//  
//
//  Created by 柿崎逸 on 2023/12/06.
//

import SwiftUI
import ComposableArchitecture

public struct AddressResult: Reducer {
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case .onAppear:
                return .none
            }
        }
    }
}

public struct AddressResultView: View {
    let store: StoreOf<AddressResult>
    public init(store: StoreOf<AddressResult>) {
        self.store = store
    }
    public var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    AddressResultView(
        store: .init(
            initialState: AddressResult.State()) {
                AddressResult()
            }
    )
}
