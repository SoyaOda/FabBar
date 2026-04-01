import UIKit

/// Configuration for the floating action button (FAB) in FabBar.
///
/// The FAB appears as a circular glass button next to the tab items,
/// morphing with the iOS 26 glass effect.
@available(iOS 26.0, *)
public struct FabBarAction {
    /// The SF Symbol name for the button icon. Used when `customImage` is nil.
    public let systemImage: String?

    /// A custom UIImage for the button icon. Takes precedence over `systemImage`.
    public let customImage: UIImage?

    /// The accessibility label for VoiceOver users.
    public let accessibilityLabel: String

    /// The action to perform when the button is tapped.
    public let action: () -> Void

    /// Creates a floating action button with an SF Symbol icon.
    public init(
        systemImage: String,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.systemImage = systemImage
        self.customImage = nil
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    /// Creates a floating action button with a custom UIImage.
    public init(
        customImage: UIImage,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.systemImage = nil
        self.customImage = customImage
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }
}
