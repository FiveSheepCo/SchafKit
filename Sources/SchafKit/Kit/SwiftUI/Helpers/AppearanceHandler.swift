import Foundation
import SwiftUI

#if os(iOS)

private struct AppearanceHandler: UIViewControllerRepresentable {
    
    let onDidAppear: () -> Void
    let onWillDisappear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<AppearanceHandler>) -> UIViewController {
        context.coordinator
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            onDidAppear: onDidAppear,
            onWillDisappear: onWillDisappear
        )
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onDidAppear: () -> Void
        let onWillDisappear: () -> Void

        init(
            onDidAppear: @escaping () -> Void,
            onWillDisappear: @escaping () -> Void
        ) {
            self.onDidAppear = onDidAppear
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

private struct AppearanceModifier: ViewModifier {
    var onDidAppear: () -> Void = {}
    var onWillDisappear: () -> Void = {}

    func body(content: Content) -> some View {
        content
            .background(
                AppearanceHandler(
                    onDidAppear: onDidAppear,
                    onWillDisappear: onWillDisappear
                )
            )
    }
}

public extension View {
    
    func onDidAppear(perform handler: @escaping () -> Void) -> some View {
        self.modifier(
            AppearanceModifier(onDidAppear: handler)
        )
    }
    
    func onWillDisappear(perform handler: @escaping () -> Void) -> some View {
        self.modifier(
            AppearanceModifier(onWillDisappear: handler)
        )
    }
    
    func on(didAppear: @escaping () -> Void, willDisappear: @escaping () -> Void) -> some View {
        self.modifier(
            AppearanceModifier(onDidAppear: didAppear, onWillDisappear: willDisappear)
        )
    }
}

#endif
