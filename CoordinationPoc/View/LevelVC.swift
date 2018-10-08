//
//  LevelVC.swift
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






class LevelVC : UIViewController, NextHandReceiver {
    
    @IBOutlet weak var pathView: UIView!
    @IBOutlet weak var handLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var shapeView: ShapeView!
    
    
    var viewModel : LevelViewModel? {
        
        didSet {
            
            fillUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.viewWillAppear()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.viewDidAppear()
    }
    
    
    
    fileprivate func styleUI() {
        
    }
    
    fileprivate func fillUI() {
        
        guard isViewLoaded else {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        self.shapeView.viewModel = viewModel.shapeViewModel
        
        viewModel.handIdentifier.bindAndFire { [unowned self] in self.handLabel.text = $0 }
        viewModel.currentTime.bindAndFire { [unowned self] in self.timerLabel.text = $0 }
        viewModel.path.bindAndFire { [unowned self] in self.levelName.text = $0 }
        viewModel.newHand.bind { [unowned self] hand in
            if hand != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "nextHandChoiceVC") as! NextHandChoiceVC
                vc.delegate = self
                
                self.present(vc, animated: true, completion: nil)
            }
        }
        viewModel.pathIsHidden.bind { [unowned self] in
            if $0 {
                self.hideCurrentPath()
            } else {
                self.showCurrentPath()
            }
        }
    }
    
    @IBAction func endLevel(_ sender: Any) {
        
        viewModel?.endLevel()
        
        self.shapeView.translateBallToTheEnd()
    }
    
    private func showNotification(text: String, duration:Int) {
        
        
    }
    
    fileprivate func showCurrentPath() {
        
        self.pathView.fadeIn { finished in
            self.viewModel?.pathDidShow()
        }
    }
    
    fileprivate func hideCurrentPath() {
        
        self.pathView.fadeOut { finished in
            self.viewModel?.pathDidHide()
        }
    }
    
    
    func didChooseNextHandReady(_ answer: Bool, from controller: UIViewController) {
        
        viewModel?.didChooseNextHandReady(answer)
    }
    
}
