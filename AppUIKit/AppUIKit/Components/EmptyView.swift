//
//  EmptyView.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

public class EmptyView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var noDataImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!
    
    // MARK: - Properties
    
    private var retryButtonAction: (()->Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadFromNib() else { return }
        view.frame = bounds
        tryAgainButton.roundCorners(cornerRadius: 5.0)
        addSubview(view)
    }
    
    private func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: - Configuration
    
    func configure(imageName: String?, message: String, buttonTitle: String?, buttonAction: (()->Void)?) {
        if let imageName = imageName {
            noDataImageView.image = UIImage(named: imageName)
        } else {
            noDataImageView.isHidden = true
        }
        
        messageLabel.text = message
        
        if let buttonTitle = buttonTitle {
            tryAgainButton.setTitle(buttonTitle, for: .normal)
            retryButtonAction = buttonAction
        } else {
            tryAgainButton.isHidden = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func tryAgainButtonTapped(_ sender: UIButton) {
        retryButtonAction?()
    }
}
