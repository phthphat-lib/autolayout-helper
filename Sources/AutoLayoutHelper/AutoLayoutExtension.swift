//
//  File.swift
//
//
//  Created by Phat Pham on 03/07/2021.
//

import UIKit

extension UIView {
    public func addFillSubview(_ view: UIView, inSafeArea: InSafeArea = .no, padding: UIEdgeInsets = .allSides(0)) {
        self.addSubview(view)
        view.fillSuperview(padding: padding, inSafeArea: inSafeArea)
    }
    
    @discardableResult
    public func fillSuperview(
        padding: UIEdgeInsets = .allSides(0),
        inSafeArea: InSafeArea = .no
    ) -> AnchoredConstraints {
        guard let superview = self.superview else { return .init() }
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchor = AnchoredConstraints()
        if #available(iOS 11.0, *), inSafeArea != .no {
            anchor = self.anchor(
                .top(superview.safeAreaLayoutGuide.topAnchor, constant: padding.top),
                .leading(superview.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
                .trailing(superview.safeAreaLayoutGuide.trailingAnchor, constant: padding.right)
            )
            
            if inSafeArea == .exceptBottom {
                anchor.bottom = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom)
                anchor.bottom?.isActive = true
            }
            if inSafeArea == .full {
                anchor.bottom = self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom)
                anchor.bottom?.isActive = true
            }
        } else {
            anchor = self.anchor(
                .top(superview.topAnchor, constant: padding.top),
                .leading(superview.leadingAnchor, constant: padding.left),
                .trailing(superview.trailingAnchor, constant: padding.right),
                .bottom(superview.bottomAnchor, constant: padding.bottom)
            )
        }
        return anchor
    }
}

public enum InSafeArea {
    case no, full, exceptBottom
}

extension UIEdgeInsets {
    static public func allSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
}
