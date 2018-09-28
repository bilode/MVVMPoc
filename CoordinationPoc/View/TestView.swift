//
//  TestView.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 21/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeOut(completion:((Bool) -> Void)?) {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func fadeIn(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}






class TestView : UIView {
    
    @IBOutlet weak var pathView: UIView!
    @IBOutlet weak var handLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var shapeView: ShapeView!
    
    
    var viewModel : TestViewModel? {
        
        didSet {
            fillUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let nib = UINib(nibName: "TestView", bundle: nil)
        let playerView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(playerView)
        
        let coordinationTest = CoordinationTest()
        self.viewModel = TestViewModel(from: coordinationTest)
        
        self.shapeView.viewModel = viewModel?.shapeViewModel
        
        fillUI()
        styleUI()
    }
    
    fileprivate func styleUI() {
        
    }
    
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.handIdentifier.bindAndFire { [unowned self] in self.handLabel.text = $0 }
        viewModel.currentTime.bindAndFire { [unowned self] in self.timerLabel.text = $0 }
        viewModel.pathIsHidden.bind { [unowned self] in
            if $0 {
                self.pathView.fadeOut { finished in
                    self.pathDidDisappear()
                }
            } else {
                self.pathView.fadeIn { finished in
                    self.pathDidAppear()
                }
            }
        }
        viewModel.path.bindAndFire { [unowned self] in self.levelName.text = $0 }
    }
    
    @IBAction func endLevel(_ sender: Any) {
        viewModel?.endLevel()
    }
    
    fileprivate func pathDidDisappear() {
        viewModel?.pathDidDisappear()
        print("pathDidDisappear")
    }
    
    fileprivate func pathDidAppear() {
        viewModel?.pathDidAppear()
        print("pathDidAppear")
    }
    
    private func showNotification(text: String, duration:Int) {
        
        
    }
}
