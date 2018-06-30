//
//  ViewController.swift
//  drone
//
//  Created by Pedro Antonio Vazquez Rodriguez on 21/06/18.
//  Copyright © 2018 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    let kStartingPosition = SCNVector3(0, 0, -0.6)
    let kAnimationDurationMoving: TimeInterval = 0.2
    let kMovingLengthPerLoop: CGFloat = 0.05
    let kRotationRadianPerLoop: CGFloat = 0.2
    
    let sceneView : ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dinosaur = Dinosaur()
    
    let drone = Drone()
    
    let upFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
        button.addTarget(self, action: #selector(handleUpFirstButton), for: .touchUpInside)
        return button
    }()
    let leftFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
       // button.addTarget(self, action: #selector(handleLeftFirstButton), for: .touchUpInside)
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:))))
        return button
    }()
    let rightFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "rigthArrow"), for: .normal)
         button.addTarget(self, action: #selector(handleRightFirstButton), for: .touchUpInside)
        return button
    }()
    let downFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
         button.addTarget(self, action: #selector(handleDownFirstButton), for: .touchUpInside)
        return button
    }()
    
    let upSecondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
        button.addTarget(self, action: #selector(handleUpSecondButton), for: .touchUpInside)
        return button
    }()
    let leftSecondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        button.addTarget(self, action: #selector(handleLeftSecondButton), for: .touchUpInside)
        return button
    }()
    let rightSecondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRightSecondButton), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "rigthArrow"), for: .normal)
        return button
    }()
    let downSecondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
        button.addTarget(self, action: #selector(handleDownSecondButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(sceneView)
        view.addSubview(upFirstButton)
        view.addSubview(leftFirstButton)
        view.addSubview(rightFirstButton)
        view.addSubview(downFirstButton)
        view.addSubview(upSecondButton)
        view.addSubview(leftSecondButton)
        view.addSubview(rightSecondButton)
        view.addSubview(downSecondButton)
        
        setupViews()
        setupScene()
        addDino()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupConfiguration()
        addDrone()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupViews(){
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        upFirstButton.bottomAnchor.constraint(equalTo: downFirstButton.topAnchor, constant: -50).isActive = true
        upFirstButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 75).isActive = true
        upFirstButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        upFirstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        downFirstButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        downFirstButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 75).isActive = true
        downFirstButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        downFirstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        leftFirstButton.rightAnchor.constraint(equalTo: downFirstButton.leftAnchor).isActive = true
        leftFirstButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        leftFirstButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        leftFirstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        rightFirstButton.leftAnchor.constraint(equalTo: downFirstButton.rightAnchor).isActive = true
        rightFirstButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        rightFirstButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        rightFirstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //second section
        upSecondButton.bottomAnchor.constraint(equalTo: downSecondButton.topAnchor, constant: -50).isActive = true
        upSecondButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -75).isActive = true
        upSecondButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        upSecondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        downSecondButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        downSecondButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -75).isActive = true
        downSecondButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        downSecondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        leftSecondButton.rightAnchor.constraint(equalTo: downSecondButton.leftAnchor).isActive = true
        leftSecondButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        leftSecondButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        leftSecondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        rightSecondButton.leftAnchor.constraint(equalTo: downSecondButton.rightAnchor).isActive = true
        rightSecondButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        rightSecondButton.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        rightSecondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupScene() {
        let scene = SCNScene()
        sceneView.scene = scene
        
    }
    
    
    func setupConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration)
        
        
        
    }
    func addDrone()  {
        drone.loadModel()
        drone.position = kStartingPosition
        drone.rotation = SCNVector4Zero
        sceneView.scene.rootNode.addChildNode(drone)
        
    }
    func addDino()  {
        dinosaur.loadModel()
        sceneView.scene.rootNode.addChildNode(dinosaur)
    }
    
    @objc func handleUpFirstButton (){
    
    }
    @objc func handleDownFirstButton (){
        
    }
    @objc func handleLeftFirstButton (){
        
    }
    @objc func handleRightFirstButton (){
        
    }
    @objc func handleUpSecondButton (){
        
    }
    @objc func handleDownSecondButton (){
        
    }
    @objc func handleLeftSecondButton (){
        
    }
    @objc func handleRightSecondButton (){
        
    }
    @objc func longTap(_ sender: UIGestureRecognizer){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
        }
    }
    
    private func rotateDrone(yRadian: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.rotateBy(x: 0, y: yRadian, z: 0, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    
    private func moveDrone(x: CGFloat, z: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: x, y: 0, z: z, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    
    private func execute(action: SCNAction, sender: UILongPressGestureRecognizer) {
        let loopAction = SCNAction.repeatForever(action)
        if sender.state == .began {
            drone.runAction(loopAction)
        } else if sender.state == .ended {
            drone.removeAllActions()
        }
    }
    
    private func deltas() -> (sin: CGFloat, cos: CGFloat) {
        return (sin: kMovingLengthPerLoop * CGFloat(sin(drone.eulerAngles.y)), cos: kMovingLengthPerLoop * CGFloat(cos(drone.eulerAngles.y)))
    }
    
    

    

}

