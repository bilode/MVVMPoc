//
//  NextHandChoiceVC.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 04/10/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit


protocol NextHandReceiver : class {

    func didChooseNextHandReady(_ answer: Bool, from controller: UIViewController)
}



class NextHandChoiceVC : UIViewController {
    
    weak var delegate: NextHandReceiver?
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func noAction(_ sender: Any) {
        
        self.didPickAnswer(answer: false)
    }
    
    
    
    @IBAction func yesAction(_ sender: Any) {
        
        self.didPickAnswer(answer: true)
    }
    
    
    
    fileprivate func didPickAnswer(answer: Bool) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        self.dismiss(animated: true) {
            
            delegate.didChooseNextHandReady(answer, from: self)
        }
    }
}
