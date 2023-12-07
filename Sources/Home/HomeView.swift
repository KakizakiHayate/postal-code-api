//
//  ContentView.swift
//  PostalCodeAPI
//
//  Created by 柿崎逸 on 2023/12/05.
//

import SwiftUI
import ComposableArchitecture

public struct Home: Reducer {
    public struct State: Equatable {
        var text = "kk"
        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case tapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                print("onAppearが実行されました。")
                return .none
            case .tapped:
                state.text = "uu"
                return .none
            }
        }
    }
}

public struct HomeView: View {
    let store: StoreOf<Home>
    @State private var texts = ""

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    TextField("郵便番号を入力", text: $texts)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        viewStore.send(.tapped)
                    } label: {
                        Text("検索")
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Text("\(viewStore.text)")
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
