import SwiftUI

/// A customizable iOS 26 glass tab bar with a floating action button.
///
/// FabBar provides a native-looking iOS 26 tab bar where you control what goes in it,
/// including a FAB that morphs with the glass effect.
///
/// ## Usage
///
/// ```swift
/// enum AppTab: Hashable {
///     case home, explore, profile
/// }
///
/// struct ContentView: View {
///     @State private var selectedTab: AppTab = .home
///
///     var body: some View {
///         VStack {
///             // Your tab content here
///
///             FabBar(
///                 selection: $selectedTab,
///                 items: [
///                     FabBarItem(tab: .home, title: "Home", systemImage: "house.fill"),
///                     FabBarItem(tab: .explore, title: "Explore", systemImage: "compass"),
///                     FabBarItem(tab: .profile, title: "Profile", systemImage: "person.fill"),
///                 ],
///                 action: FabAction(
///                     systemImage: "plus",
///                     accessibilityLabel: "Add Item"
///                 ) {
///                     // Handle tap
///                 }
///             )
///         }
///     }
/// }
/// ```

@available(iOS 26.0, *)
public struct FabBar<Tab: Hashable>: View {
    /// The currently selected tab.
    @Binding public var selection: Tab

    /// The tab items to display.
    public let items: [FabBarItem<Tab>]

    /// The floating action button configuration.
    public var action: FabAction

    /// Callback invoked when the user taps an already-selected tab.
    public var onReselect: ((Tab) -> Void)?

    /// Creates a FabBar with the specified configuration.
    ///
    /// - Parameters:
    ///   - selection: A binding to the currently selected tab.
    ///   - items: The tab items to display.
    ///   - action: The floating action button configuration.
    ///   - onReselect: Optional callback invoked when the user taps an already-selected tab.
    public init(
        selection: Binding<Tab>,
        items: [FabBarItem<Tab>],
        action: FabAction,
        onReselect: ((Tab) -> Void)? = nil
    ) {
        self._selection = selection
        self.items = items
        self.action = action
        self.onReselect = onReselect
    }

    public var body: some View {
        if items.isEmpty {
            Color.clear
                .frame(height: Constants.barHeight)
                .onAppear {
                    fabBarLogger.warning("FabBar initialized with empty items array - nothing will be displayed")
                }
        } else {
            GeometryReader { geo in
                FabBarRepresentable(
                    size: geo.size,
                    items: items,
                    action: action,
                    activeTab: $selection,
                    onReselect: onReselect
                )
            }
            .frame(height: Constants.barHeight)
        }
    }
}
