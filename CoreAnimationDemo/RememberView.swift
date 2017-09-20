//
//  RememberView.swift
//  CoreAnimationDemo
//
//  Created by redtwowolf on 19/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class RememberView: UIView, Shadowable {
    
    class func loadFromNib() -> UIView {
        return UINib(nibName: "RememberView", bundle: nil)
            .instantiate(withOwner: nil, options: nil)
            .first as! RememberView
    }
    
    // MARK: - Properties

    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var foldView: UIView!
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var transform = CATransform3DIdentity
        transform.m34 = 1 / -900
        layer.sublayerTransform = transform
        
        foldView.layer.isDoubleSided = false
        foldView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        addBorder()
        shadow()
        
        phoneTextField.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    
    // MARK: - IBAction
    
    @IBAction func payBtnClicked(_ sender: UIButton) {
        guard let text = phoneTextField.text, !text.isEmpty else {
            layer.shake()
            return
        }
        configPayBtn(.push("Sending", .gray))
        DispatchQueue.mainDelay(1.5) {
            self.configPayBtn(.pop("Sent", .green))
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: .allowAnimatedContent,
                       animations: {
                        
                        self.folding(by: sender.isOn)
                        
        }, completion: nil)
    }
    
    
    // MARK: - Private Func
    
    private func addBorder() {
        border()
        headerView.border()
        foldView.border()
        phoneTextField.border()
        payBtn.border()
    }

    private func layout() {
        foldView.frame = CGRect(x: headerView.frame.origin.x,
                                y: headerView.frame.maxY - headerView.layer.borderWidth,
                                width: headerView.bounds.width,
                                height: 100)
        
        payBtn.frame.origin.y = foldView.frame.maxY + 10
        frame.size.height = payBtn.frame.maxY + 10
    }
    
    
    private func folding(by on: Bool) {
        let angle = on ? 0 : -90
        foldView.layer.transform = CATransform3DMakeRotation(angle.toRadian, 1, 0, 0)
        layout()
    }
    
    private func configPayBtn(_ type: TransitionType) {
        payBtn.titleLabel?.layer.addTransition()
        
        switch type {
        case let .none(text, color),
             let .push(text, color),
             let .pop(text, color):
            payBtn.setTitle(text, for: .normal)
            payBtn.setTitleColor(color, for: .normal)
        }
    }
}

enum TransitionType {
    case none(String, UIColor)
    case push(String, UIColor)
    case pop(String, UIColor)
}


// MARK: - UITextFieldDelegate

extension RememberView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.resignFirstResponder()
        return true
    }
}
