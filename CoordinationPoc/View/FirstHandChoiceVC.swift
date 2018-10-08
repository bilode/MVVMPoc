//
//  FirstHandChoiceVC.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 03/10/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit

protocol FirstHandReceiver : class {
    
    func didChooseFirstHand(_ hand: Hand, from controller: UIViewController)
}



class FirstHandChoiceVC : UIViewController {
    
    weak var delegate: FirstHandReceiver?
    
    var viewModel: FirstHandChoiceViewModel? {
        didSet {
            
            self.fillUI()
        }
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillUI()
    }
    
    func fillUI() {
        
        guard isViewLoaded else {
            return
        }
        
        guard let viewModel = self.viewModel else {
            
            return
        }
        
        self.questionLabel.text = viewModel.questionText
        self.leftButton.setImage(UIImage(named: viewModel.leftHandImageName), for: .normal)
        self.rightButton.setImage(UIImage(named: viewModel.rightHandImageName), for: .normal)
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        
        self.didPickAnswer(hand: .left)
    }

    @IBAction func rightButtonAction(_ sender: Any) {
        
        self.didPickAnswer(hand: .right)
    }
    
    
    fileprivate func didPickAnswer(hand: Hand) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        self.dismiss(animated: true) {
            
            delegate.didChooseFirstHand(hand, from: self)
        }
    }
}
