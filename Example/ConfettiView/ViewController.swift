//
//  ViewController.swift
//  ConfettiView
//
//  Created by lo-fo on 06/07/2017.
//  Copyright (c) 2017 lo-fo. All rights reserved.
//

import UIKit
import ConfettiView

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        let confettiView = ConfettiView(frame: self.view.frame)
        self.view.addSubview(confettiView)
        
        let bombLayer = CALayer()
        let bombImage = UIImage(named: "confetti_bomb")
        bombLayer.contents = bombImage?.cgImage
        bombLayer.opacity = 0.4
        
        let elixirLayer = CALayer()
        let elixirImage = UIImage(named: "confetti_elixir")
        elixirLayer.contents = elixirImage?.cgImage
        elixirLayer.opacity = 0.4
        
        let potionLayer = CALayer()
        let potionImage = UIImage(named: "confetti_potion")
        potionLayer.contents = potionImage?.cgImage
        potionLayer.opacity = 0.4
        
        let spellbookLayer = CALayer()
        let spellbookImage = UIImage(named: "confetti_spellbook")
        spellbookLayer.contents = spellbookImage?.cgImage
        spellbookLayer.opacity = 0.4
        
        confettiView.confettiDensity =  confettiView.frame.size.height / 16 * 2
        confettiView.confettiSize = confettiView.frame.size.height / 16
        
        confettiView.addConfetti(layer: bombLayer)
        confettiView.addConfetti(layer: elixirLayer)
        confettiView.addConfetti(layer: potionLayer)
        confettiView.addConfetti(layer: spellbookLayer)
        
        confettiView.render()
    }

}

