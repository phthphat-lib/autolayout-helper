
import UIKit

extension UIView {
    @discardableResult
    public func anchor(_ anchors: Anchor...) -> AnchoredConstraints {
        var constraint = AnchoredConstraints()
        anchors.forEach { anchor in
            switch anchor {
            case .top(let _anchor, let constant):
                constraint.top = self.topAnchor.constraint(equalTo: _anchor, constant: constant)
            case .leading(let _anchor, let constant):
                constraint.leading = self.leadingAnchor.constraint(equalTo: _anchor, constant: constant)
            case .bottom(let _anchor, let constant):
                constraint.bottom = self.bottomAnchor.constraint(equalTo: _anchor, constant: constant)
            case .trailing(let _anchor, let constant):
                constraint.trailing = self.trailingAnchor.constraint(equalTo: _anchor, constant: constant)
            case .centerX(let _anchor, let constant):
                constraint.centerX = self.centerXAnchor.constraint(equalTo: _anchor, constant: constant)
            case .centerY(let _anchor, let constant):
                constraint.centerY = self.centerYAnchor.constraint(equalTo: _anchor, constant: constant)
            case .height(let constant):
                constraint.height = self.heightAnchor.constraint(equalToConstant: constant)
            case .width(let constant):
                constraint.width = self.widthAnchor.constraint(equalToConstant: constant)
            case .heightRelate(let _anchor, let multi, let constant):
                constraint.widthRelated = self.widthAnchor.constraint(equalTo: _anchor, multiplier: multi, constant: constant)
            case .widthRelate(let _anchor, let multi, let constant):
                constraint.heightRelated = self.heightAnchor.constraint(equalTo: _anchor, multiplier: multi, constant: constant)
            }
        }
        constraint.activeAllConstraints()
        return constraint
    }
}

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, heightRelated, height, widthRelated, width, centerX, centerY: NSLayoutConstraint?
    
    func activeAllConstraints() {
        [top, leading, bottom, trailing, heightRelated, height, widthRelated, width, centerX, centerY].forEach { constraint in
            constraint?.isActive = true
        }
    }
}

public enum Anchor {
    //Edge
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    //Center
    case centerX(_ xAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerY(_ yAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    //Width, Height
    case height(_ constant: CGFloat)
    case width(_ constant: CGFloat)
    case heightRelate(to: NSLayoutDimension, multi: CGFloat = 1.0, constant: CGFloat = 0.0)
    case widthRelate(to: NSLayoutDimension, multi: CGFloat = 1.0, constant: CGFloat = 0.0)
}
