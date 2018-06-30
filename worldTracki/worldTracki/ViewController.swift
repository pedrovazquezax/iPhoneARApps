//
//  ViewController.swift
//  worldTracki
//
//  Created by Pedro Antonio Vazquez Rodriguez on 19/06/18.
//  Copyright © 2018 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    let configuration = ARWorldTrackingConfiguration()
    
    let  arView: ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  addButton :UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    lazy var  resetButton :UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.yellow
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(arView)
        view.addSubview(addButton)
        view.addSubview(resetButton)
        self.arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.arView.session.run(configuration)
        setUpItems()
        self.arView.autoenablesDefaultLighting = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpItems() {
        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        resetButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    @objc func handleAdd() {
        

//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
//        node.geometry = SCNSphere(radius: 0.5)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.4, height: 0.4)
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
//        node.geometry = SCNPlane(width: 0.3, height: 0.3)
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x:0, y:0))
//        path.addLine(to: CGPoint(x:0, y:0.2))
//        path.addLine(to: CGPoint(x:0.2,y:0.3))
//        path.addLine(to: CGPoint(x:0.4,y:0.2))
//        path.addLine(to: CGPoint(x:0.4,y:0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        let x = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
//        let y = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
//        let z = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
        boxNode.position = SCNVector3(0.2,0.25,-0.2)
        
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.2))
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        cylinderNode.position = SCNVector3(-0.2,-0.3,0.2)
        
        let nodeMiniBox = SCNNode(geometry: SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.025))
        nodeMiniBox.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        nodeMiniBox.position = SCNVector3(-0.2,-0.3,0.2)
        
        let planeNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        planeNode.position = SCNVector3(0,-0.05,0.06)
        
        let node  = SCNNode()
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.position = SCNVector3(0.2,0.3,-0.2)
        node.addChildNode(planeNode)
        
        
        
        
        self.arView.scene.rootNode.addChildNode(node)
        self.arView.scene.rootNode.addChildNode(cylinderNode)
        self.arView.scene.rootNode.addChildNode(boxNode)
        self.arView.scene.rootNode.addChildNode(nodeMiniBox)
        
    }

    @objc func handleReset(){
        self.restartSession()
    }
    func restartSession() {
        self.arView.session.pause()
        self.arView.scene.rootNode.enumerateChildNodes({(node, _) in
            node.removeFromParentNode()
        })
        self.arView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
        
    }
    func randomNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
}

