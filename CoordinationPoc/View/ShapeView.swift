//
//  ShapeView.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 27/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import UIKit

class ShapeView : UIView {
    
    
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var endView: UIView!
    
    var viewModel: ShapeViewModel? {
        didSet {
            
            fillUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let nib = UINib(nibName: "ShapeView", bundle: nil)
        let playerView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(playerView)
        
        styleUI()
    }
    
    func fillUI() {
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        viewModel.current.bindAndFire { [unowned self] in
            let frame = self.frame
            self.ballView.center = CGPoint(x: frame.maxX * CGFloat($0.x) / 100.0, y: frame.maxY * CGFloat($0.y) / 100.0)
        }
        
        viewModel.end.bindAndFire { [unowned self] in
            let frame = self.frame
            self.endView.center = CGPoint(x: frame.maxX * CGFloat($0.x) / 100.0, y: frame.maxY * CGFloat($0.y) / 100.0)
        }
    }
    
    func styleUI() {
        
        
    }
}
