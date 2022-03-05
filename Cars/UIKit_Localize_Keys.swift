//
//  UIKit_Localize_Keys.swift
//  Cars
//
//  Created by Mohamed Hashem on 21/02/2022.
//
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UILabel {
    @IBInspectable
    var localizedTextKey: String {
        set{
            self.text = NSLocalizedString(newValue, comment: "")
        }

        get{
            return text ?? ""
        }
    }
}

extension UISegmentedControl {
    @IBInspectable
    var lSe0Key: String {
        set{
            self.setTitle(newValue, forSegmentAt: 0)
        }

        get{
            return titleForSegment(at: 0) ?? ""
        }
    }

    @IBInspectable
    var lSe1Key: String {
        set{
            self.setTitle(newValue, forSegmentAt: 1)
        }

        get{
            return titleForSegment(at: 1) ?? ""
        }
    }
}

extension UITextView {
    @IBInspectable
    var localizedTextKey: String {
        set {
            self.text = newValue.localized
        }
        get{
            return text ?? ""
        }
    }
}

extension UIButton {
    @IBInspectable
    var localizedNormalTextKey: String {
        set{
            setTitle(newValue.localized, for: .normal)
        }

        get{
            return titleLabel?.text ?? ""
        }
    }

    @IBInspectable
    var localizedSelectedTextKey: String {
        set{
            setTitle(newValue.localized, for: .selected)
        }

        get{
            return titleLabel?.text ?? ""
        }
    }

    @IBInspectable
    var localizedDisableTextKey: String {
        set{
            setTitle(newValue.localized, for: .selected)
        }

        get{
            return titleLabel?.text ?? ""
        }
    }
}

extension UISearchBar {
    @IBInspectable
    var KeyPlaceholder: String {
        set{
            self.placeholder = newValue.localized
        }

        get{
            return placeholder ?? ""
        }
    }
}

extension UITabBarItem {
    @IBInspectable
    var localizeTitle: String {
        set{
            self.title = newValue.localized
        }

        get{
            return title ?? ""
        }
    }
}

extension UINavigationItem {
    @IBInspectable
    var localizedTextKey: String {
        set{
            self.title = newValue.localized
        }

        get{
            return title ?? ""
        }
    }
}

extension UIBarButtonItem {
    @IBInspectable
    var localizedTextKeyButtonLeft: String {
        set{
            self.title = newValue.localized
        }

        get{
            return title ?? ""
        }
    }
}

extension UITextField {
    @IBInspectable
    var KeyPlaceholder: String {
        set{
            self.placeholder = newValue.localized
        }

        get{
            return placeholder ?? ""
        }
    }

    @IBInspectable
    var textFieldData: String {
        set{
            self.text = newValue.localized
        }

        get{
            return text ?? ""
        }
    }
}

extension UIImageView {

    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
