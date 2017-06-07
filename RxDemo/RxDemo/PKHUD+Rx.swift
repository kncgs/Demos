//
//  PKHUD+Rx.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.
//

import PKHUD
import RxSwift
import RxCocoa

public struct RxHUDValue {
    
    let type: HUDContentType
    let delay: TimeInterval
    
    init(type: HUDContentType, delay: TimeInterval = 2.0) {
        self.type = type
        self.delay = delay
    }
}

extension HUD {
    
    public static var rx_flash: UIBindingObserver<PKHUD, RxHUDValue> {
        return PKHUD.sharedHUD.rx.flash
    }
    
    public static var rx_loading: UIBindingObserver<PKHUD, Bool> {
        return PKHUD.sharedHUD.rx.loading
    }
    
    public static var rx_whiteLoading: UIBindingObserver<PKHUD, Bool> {
        return PKHUD.sharedHUD.rx.imageFlash
    }
}

extension Reactive where Base: PKHUD {
    
    
    
    public var imageFlash: UIBindingObserver<Base, Bool> {
        MainScheduler.ensureExecutingOnScheduler()
        
        return UIBindingObserver(UIElement: base) { (control, value) in
            if value == true {
                control.contentView = Base.contentView(.rotatingImage(UIImage(named: "alert_waiting_img")))
            } else {
                control.endLoading()
            }
        }
    }
    
    public var flash: UIBindingObserver<Base, RxHUDValue> {
        MainScheduler.ensureExecutingOnScheduler()
        
        return UIBindingObserver(UIElement: base) { (control, value) in
            control.contentView = Base.contentView(value.type)
            control.show()
            control.hide(afterDelay: value.delay)
        }
    }
    
    public var loading: UIBindingObserver<Base, Bool> {
        MainScheduler.ensureExecutingOnScheduler()
        
        return UIBindingObserver(UIElement: base) { (control, value) in
            if value == true {
                control.beginLoading()
            } else {
                control.endLoading()
            }
        }
    }
}

extension PKHUD {
    
    public func beginLoading() {
        self.contentView = PKHUD.contentView(.progress)
        self.show()
    }
    
    public func endLoading() {
        self.hide(true)
    }
    
    fileprivate static func contentView(_ content: HUDContentType) -> UIView {
        switch content {
        case .success:
            return PKHUDSuccessView()
        case .error:
            return PKHUDErrorView()
        case .progress():
            return PKHUDProgressView()
        case let .image(image):
            return PKHUDSquareBaseView(image: image)
        case let .rotatingImage(image):
            return PKHUDRotatingImageView(image: image)
            
        case let .labeledSuccess(title, subtitle):
            return PKHUDSuccessView(title: title, subtitle: subtitle)
        case let .labeledError(title, subtitle):
            return PKHUDErrorView(title: title, subtitle: subtitle)
        case let .labeledProgress(title, subtitle):
            return PKHUDProgressView(title: title, subtitle: subtitle)
        case let .labeledImage(image, title, subtitle):
            return PKHUDSquareBaseView(image: image, title: title, subtitle: subtitle)
        case let .labeledRotatingImage(image, title, subtitle):
            return PKHUDRotatingImageView(image: image, title: title, subtitle: subtitle)
            
        case let .label(text):
            return PKHUDTextView(text: text)
        case .systemActivity:
            return PKHUDSystemActivityIndicatorView()
        }
    }
}

