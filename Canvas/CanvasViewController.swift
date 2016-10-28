//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Kyler Blue on 10/24/16.
//  Copyright © 2016 Kyler Blue. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        trayDownOffset = 250
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanTray(_ sender: AnyObject) {
        
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            print("Gesture began")
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture is changing")
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                    }, completion: nil)
            }   else  {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                    }, completion: nil)
            }
        }
        print("Gesture ended")
    }
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            print("Gesture began")
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.isUserInteractionEnabled = true
            
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector(("onImagePan")))
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 1.2, y: 1.2)
                
            })
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended")
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.8, y: 0.8)
                }, completion: nil)

            
            
        }
        
        
    }
    
    func onImagePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
}




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


