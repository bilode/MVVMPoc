//
//  ExerciseViewController.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 21/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "coordinationVC") as! CoordinationVC
//        vc.viewModel = TestViewModel(fromLevel: CoordinationLevel(withJson: ""))
        
        self.insertChildController(vc, intoParentView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

