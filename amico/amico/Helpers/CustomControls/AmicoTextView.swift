//
//  AmicoTextView.swift
//  amico
//
//  Created by Yuriy B. on 4/8/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

public protocol AmicoTextViewDelegate: UITextViewDelegate {
    /// Tells the delegate that the growing text view did change height.
    func amicoTextViewDelegate(textView: AmicoTextView, didChangeHeightFrom growingTextViewHeightBegin: CGFloat, to growingTextViewHeightEnd: CGFloat)
    /// Tells the delegate that the growing text view will change height.
    func amicoTextViewDelegate(textView: AmicoTextView, willChangeHeightFrom growingTextViewHeightBegin: CGFloat, to growingTextViewHeightEnd: CGFloat)
}

///UITextView subclass that automatically grows and shrinks based on the size of user input and can be constrained by maximum and minimum number of lines.
@IBDesignable public class AmicoTextView: UITextView {
    // MARK: - Private Properties
    private var estimatedHeight: CGFloat {
        let estimationTextStorage = NSTextStorage(attributedString: attributedText)
        estimationTextStorage.addLayoutManager(estimationLayoutManager)

        estimationTextContainer.lineFragmentPadding = textContainer.lineFragmentPadding
        estimationTextContainer.size = textContainer.size

        estimationLayoutManager.ensureLayoutForTextContainer(estimationTextContainer)

        var height = estimationLayoutManager.usedRectForTextContainer(estimationTextContainer).height + contentInset.top + contentInset.bottom + textContainerInset.top + textContainerInset.bottom
        if height < minHeight {
            height = minHeight
        } else if height > maxHeight {
            height = maxHeight
        }

        return height
    }

    private let estimationLayoutManager = NSLayoutManager()

    private let estimationTextContainer = NSTextContainer()

    private weak var heightConstraint: NSLayoutConstraint?

    private var maxHeight: CGFloat {
        return heightForNumberOfLines(maximumNumberOfLines)
    }

    private var minHeight: CGFloat {
        return heightForNumberOfLines(minimumNumberOfLines)
    }

    // MARK: - Public Properties

    /// A Boolean value that determines whether the animation of the height change is enabled. Default value is `true`.
    @IBInspectable public var animateHeightChange: Bool = true

    /// The receiver's delegate.
    public weak var growingTextViewDelegate: AmicoTextViewDelegate? {
        didSet {
            delegate = growingTextViewDelegate
        }
    }

    /// The duration of the animation of the height change. The default value is `0.35`.
    @IBInspectable public var heightChangeAnimationDuration: Double = 0.35

    /// The block which contains user defined actions that will run during the height change.
    public var heightChangeUserActionsBlock: ((growingTextViewHeightBegin: CGFloat, growingTextViewHeightEnd: CGFloat) -> Void)?

    /// The maximum number of lines before enabling scrolling. The default value is `5`.
    @IBInspectable public var maximumNumberOfLines: Int = 5 {
        didSet {
            if maximumNumberOfLines < minimumNumberOfLines {
                maximumNumberOfLines = minimumNumberOfLines
            }
            refreshHeightIfNeededAnimated(false)
        }
    }

    /// The minimum number of lines. The default value is `1`.
    @IBInspectable public var minimumNumberOfLines: Int = 1 {
        didSet {
            if minimumNumberOfLines < 1 {
                minimumNumberOfLines = 1
            } else if minimumNumberOfLines > maximumNumberOfLines {
                minimumNumberOfLines = maximumNumberOfLines
            }
            refreshHeightIfNeededAnimated(false)
        }
    }

    /// The current displayed number of lines. This value is calculated based on the height of text lines.
    public var numberOfLines: Int {
        guard let font = self.font else {
            return 0
        }

        let textRectHeight = contentSize.height - contentInset.top - contentInset.bottom - textContainerInset.top - textContainerInset.bottom
        let numberOfLines = textRectHeight / font.lineHeight

        return lround(Double(numberOfLines))
    }

    // MARK: - Superclass Properties

    override public var attributedText: NSAttributedString! {
        didSet {
            superview?.layoutIfNeeded()
        }
    }

    override public var contentSize: CGSize {
        didSet {
            guard window != nil && !CGSizeEqualToSize(oldValue, contentSize) else {
                return
            }
            if isFirstResponder() {
                refreshHeightIfNeededAnimated(animateHeightChange.boolValue)
            } else {
                refreshHeightIfNeededAnimated(false)
            }
        }
    }

    // MARK: - Object Lifecycle

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitializer()
    }

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInitializer()
    }

    // MARK: - Layout

    override public func intrinsicContentSize() -> CGSize {
        if heightConstraint != nil {
            return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric)
        } else {
            return CGSizeMake(UIViewNoIntrinsicMetric, estimatedHeight)
        }
    }

    // MARK: - Helper Methods

    private func commonInitializer() {
        contentInset = UIEdgeInsetsMake(1.0, 0.0, 1.0, 0.0)
        scrollsToTop = false
        showsVerticalScrollIndicator = false

        for constraint in constraints {
            if constraint.firstAttribute == .Height && constraint.relation == .Equal {
                heightConstraint = constraint
                break
            }
        }

        estimationLayoutManager.addTextContainer(estimationTextContainer)
    }

    private func heightForNumberOfLines(numberOfLines: Int) -> CGFloat {
        var height = contentInset.top + contentInset.bottom + textContainerInset.top + textContainerInset.bottom
        if let font = self.font {
            height += font.lineHeight * CGFloat(numberOfLines)
        }
        return ceil(height)
    }

    private func refreshHeightIfNeededAnimated(animated: Bool) {
        let oldHeight = bounds.height
        let estimatedHeight = self.estimatedHeight

        if oldHeight != estimatedHeight {
            growingTextViewDelegate?.amicoTextViewDelegate(self, willChangeHeightFrom: oldHeight, to: estimatedHeight)

            if animated {
                UIView.animateWithDuration(
                    heightChangeAnimationDuration,
                    delay: 0.0,
                    options: [.AllowUserInteraction, .BeginFromCurrentState],
                    animations: { [unowned self] () -> Void in
                        self.setHeight(estimatedHeight)
                        self.heightChangeUserActionsBlock?(growingTextViewHeightBegin: oldHeight, growingTextViewHeightEnd: estimatedHeight)

                        self.superview?.layoutIfNeeded()
                    },
                    completion: { [unowned self] (finished: Bool) -> Void in
                        self.layoutManager.ensureLayoutForTextContainer(self.textContainer)
                        self.scrollToVisibleCaretIfNeeded()

                        self.growingTextViewDelegate?.amicoTextViewDelegate(self, didChangeHeightFrom: oldHeight, to: estimatedHeight)
                    }
                )
            } else {
                setHeight(estimatedHeight)
                heightChangeUserActionsBlock?(growingTextViewHeightBegin: oldHeight, growingTextViewHeightEnd: estimatedHeight)

                superview?.layoutIfNeeded()
                layoutManager.ensureLayoutForTextContainer(textContainer)
                scrollToVisibleCaretIfNeeded()

                growingTextViewDelegate?.amicoTextViewDelegate(self, didChangeHeightFrom: oldHeight, to: estimatedHeight)
            }
        } else {
            scrollToVisibleCaretIfNeeded()
        }
    }

    private func scrollRectToVisibleConsideringInsets(rect: CGRect) {
        let insets = UIEdgeInsetsMake(contentInset.top + textContainerInset.top, contentInset.left + textContainerInset.left + textContainer.lineFragmentPadding, contentInset.bottom + textContainerInset.bottom, contentInset.right + textContainerInset.right)
        let visibleRect = UIEdgeInsetsInsetRect(bounds, insets)

        guard !CGRectContainsRect(visibleRect, rect) else {
            return
        }

        var contentOffset = self.contentOffset
        if rect.minY < visibleRect.minY {
            contentOffset.y = rect.minY - insets.top * 2
        } else {
            contentOffset.y = rect.maxY + insets.bottom * 2 - bounds.height
        }
        setContentOffset(contentOffset, animated: false)
    }

    private func scrollToVisibleCaretIfNeeded() {
        guard let textPosition = selectedTextRange?.end else {
            return
        }

        if textStorage.editedRange.location == NSNotFound && !dragging && !decelerating {
            let caretRect = caretRectForPosition(textPosition)
            let caretCenterRect = CGRectMake(caretRect.midX, caretRect.midY, 0.0, 0.0)
            scrollRectToVisibleConsideringInsets(caretCenterRect)
        }
    }

    private func setHeight(height: CGFloat) {
        if let heightConstraint = self.heightConstraint {
            heightConstraint.constant = height
        } else if !constraints.isEmpty {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        } else {
            frame.size.height = height
        }
    }
}
