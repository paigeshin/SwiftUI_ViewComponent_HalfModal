//
//  ModalHelper.swift
//  HalfModalSheet
//
//  Created by paige on 2021/11/07.
//

import SwiftUI

// Custom Half Sheet Modifier....
extension View {
    
    // VBinding Show Variable...
    func halfSheet<SheetView: View>(present: Binding<Bool>, onDimsiss: @escaping () -> ()  ,@ViewBuilder sheetView: @escaping() -> SheetView) -> some View {
        
        // why we using background or background...
        // because it will automatically use the SwiftUI frame Size only...
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: present, onEnd: onDimsiss)
            )
    }
    
}

// UIKit Integration...
struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: () -> ()
    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            // presenting Modal View...
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            // closing view when showSheet toggled again....
            uiViewController.dismiss(animated: true)
        }
    }
    
    // On Dismiss....
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
        
    }
    
}

// Custom UIHostingController for halfSheet....
class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        
        // setting presentation controller properties...
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            // to show grab portion
            presentationController.prefersGrabberVisible = true
        }
        
    }
    
}
