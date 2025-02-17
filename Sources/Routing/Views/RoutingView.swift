//
//  RoutingView.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

public struct RoutingView<RootView: View, Routes: Routable>: View {
    @StateObject private var router: Router<Routes> = .init()
    private let rootView: (Router<Routes>) -> RootView

    public init(_ routeType: Routes.Type, @ViewBuilder rootView: @escaping (Router<Routes>) -> RootView) {
        self.rootView = rootView
    }

    public var body: some View {
        NavigationStack(path: $router.stack) {
            rootView(router)
                .navigationDestination(for: Router<Routes>.Destination.self) { route in
                    route.body.environmentObject(router)
                }
        }
    }
}
