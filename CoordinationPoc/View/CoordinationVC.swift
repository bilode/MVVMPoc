//
//  CoordinationVC.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 24/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit

protocol TestCoordinator {
    
    func testDidFinish(sender: Int)
    func surveyDidFinish(sender: Int)
}


class CoordinationVC : UIViewController, FirstHandReceiver {
    
    var testViewModel: TestViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinationTest = CoordinationTest()
        
        self.testViewModel = TestViewModel(from: coordinationTest)
        
        self.fillUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        testViewModel?.startNextStep()
    }

    
    
    func fillUI() {
        
        guard let testViewModel = self.testViewModel else {
            
            return
        }
        
        testViewModel.firstHandChoiceIsReady.bind { [unowned self] in
            if $0 {
                self.presentHandChoiceView()
            }
        }
        
        testViewModel.levelsAreReady.bind { [unowned self] in
            if $0 {
                self.presentLevelsView()
            }
        }
        
        testViewModel.dataValidationChoiceIsReady.bind { [unowned self] in
            if $0 {
                self.presentDataValidationView()
            }
        }
        
        testViewModel.surveyIsReady.bind { [unowned self] in
            if $0 {
                self.presentSurveyView()
            }
        }
    }
    
    func presentHandChoiceView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "firstHandChoiceVC") as! FirstHandChoiceVC
        vc.delegate = self
        
        vc.viewModel = FirstHandChoiceViewModel(question: "Which hand ?", leftHandImageName: "left", rightHandImageName: "right")
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentLevelsView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "levelVC") as! LevelVC
        
        vc.viewModel = self.testViewModel?.levelViewModel
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentDataValidationView() {
        
    }
    
    func presentSurveyView() {
        
    }
    
    func didChooseFirstHand(_ hand: Hand, from controller: UIViewController) {
        
        self.testViewModel?.setFirstHand(hand)
    }
}
