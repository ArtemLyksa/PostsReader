//
//  UIViewController+extensions.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

extension BaseViewController {
    
    private var animationDuration: Double {
        return 0.35
    }
    
    private var overlayViewAlpha: CGFloat {
        return 0.7
    }
    
    func setupSpinner(drivenBy observable: Observable<Bool>) {
        
        let progressHud = JGProgressHUD(style: .extraLight)
        progressHud.parallaxMode = .alwaysOff
        progressHud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(overlayViewAlpha)
        overlayView.isHidden = true
        view.addSubview(overlayView)
        
        observable.distinctUntilChanged().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isBusy in
                
                guard let strongSelf = self else { return }
                
                if isBusy {
                    strongSelf.view.isUserInteractionEnabled = false
                    strongSelf.view.bringSubviewToFront(overlayView)
                    strongSelf.easeViewIn(overlayView)
                    progressHud.show(in: strongSelf.view)
                    strongSelf.view.bringSubviewToFront(progressHud)
                } else {
                    strongSelf.view.isUserInteractionEnabled = true
                    progressHud.dismiss()
                    strongSelf.easeViewOut(overlayView)
                }
                
                }, onDisposed: { [weak self] in
                    
                    guard let strongSelf = self else { return }
                    
                    strongSelf.view.isUserInteractionEnabled = true
                    progressHud.dismiss()
                    strongSelf.easeViewOut(overlayView)
                    
            }).disposed(by: disposeBag)
    }
    
    private func easeViewIn(_ view: UIView) {
        view.isHidden = false
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    
    private func easeViewOut(_ view: UIView) {
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations: {
            view.alpha = 0.0
        }, completion: { completed in
            if completed {
                view.isHidden = true
            }
        })
    }
}
