import FabBar
import SwiftUI

enum AppTab: Hashable {
    case home
    case explore
    case profile
}

private enum TabBarLayout {
    static let horizontalPadding: CGFloat = 16
    static let bottomPadding: CGFloat = 21
}

@available(iOS 26.0, *)
struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showingSheet = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: AppTab.home) {
                TabContentView(title: "Home", systemImage: "house.fill")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: AppTab.explore) {
                TabContentView(title: "Explore", systemImage: "map.fill")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: AppTab.profile) {
                TabContentView(title: "Profile", systemImage: "person.fill")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaBar(edge: .bottom) {
            FabBar(
                selection: $selectedTab,
                items: [
                    FabBarItem(tab: AppTab.home, title: "Home", systemImage: "house.fill"),
                    FabBarItem(tab: AppTab.explore, title: "Explore", systemImage: "map.fill"),
                    FabBarItem(tab: AppTab.profile, title: "Profile", systemImage: "person.fill"),
                ],
                action: FabAction(
                    systemImage: "plus",
                    accessibilityLabel: "Add"
                ) {
                    showingSheet = true
                },
                onReselect: { tab in
                    print("Reselected: \(tab)")
                }
            )
            .padding(.horizontal, TabBarLayout.horizontalPadding)
            .padding(.bottom, TabBarLayout.bottomPadding)
        }
        .ignoresSafeArea(.keyboard)
        .ignoresSafeArea(.container, edges: .bottom)
        .sheet(isPresented: $showingSheet) {
            Text("Sheet content")
                .presentationDetents([.medium])
        }
    }
}

struct TabContentView: View {
    let title: String
    let systemImage: String

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: systemImage)
                    .font(.system(size: 48))
                    .foregroundStyle(.tertiary)
                Text(title)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(title)
        }
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        ContentView()
    } else {
        Text("Requires iOS 26")
    }
}
