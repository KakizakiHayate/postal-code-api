//
//  ContentView.swift
//  PostalCodeAPI
//
//  Created by 柿崎逸 on 2023/12/05.
//

import SwiftUI
import ComposableArchitecture
import AddressResultFeature
import Entity
import ZipCloudAPIClient
import Dependencies

public struct Home: Reducer {
    public struct State: Equatable {
        var text = ""
        var addressResult = AddressResult.State()
        var isLoading = false
        var results = [Result]()

        public init() {}
    }

    public enum Action {
        case onAppear
        case search
        case addressResult(AddressResult.Action)
        case bindingAction(BindingAction)
        case searchAddress(Swift.Result<[Result], Error>)
        public enum BindingAction: Equatable {
            case textChange(String)
        }
    }

    @Dependency(\.zipCloudAPIClient) var zipCloudAPIClient

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.addressResult,
            action: /Action.addressResult
        ) {
            AddressResult()
        }

        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                print("onAppearが実行されました。")
                return .none
            case .search:
                state.isLoading = true
                return .run {
                    await $0(
                        .searchAddress(
                            Swift.Result { try await zipCloudAPIClient.searchAddresses("2700011") }
                        )
                    )
                }
            case let .bindingAction(.textChange(text)):
                state.text = text
                print(state.text)
                return .none
            case .addressResult(_):
                return .none
            case let .searchAddress(result):
                state.isLoading = false

                switch result {
                case let .success(addresses):
                    state.results = addresses
                    print("response::\(state.results[0])")
                case let .failure(error):
                    print(error)
                }
                return .none
            }
        }
    }
}



public struct HomeView: View {
    let store: StoreOf<Home>

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    TextField(
                        "郵便番号を入力",
                        text: viewStore.binding(get: { $0.text }, send: { .bindingAction(.textChange($0)) })
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        viewStore.send(.search)
                    } label: {
                        Text("検索")
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Text("\(viewStore.text)")
                AddressResultView(
                    store: store.scope(
                        state: \.addressResult,
                        action: { .addressResult($0) }
                    )
                )
            }
            .padding()
        }
    }
}

#Preview {
    HomeView(
        store: .init(
            initialState: Home.State()
        ) {
            Home()
        }
    )
}
