//
//  Drone.swift
//  drone
//
//  Created by Pedro Antonio Vazquez Rodriguez on 21/06/18.
//  Copyright © 2018 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import ARKit

class Drone: SCNNode {
    func loadModel() {
        guard  let virtualObjectScene = SCNScene(named: "Drone_dae.scn") else {
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        wrapperNode.position = SCNVector3(0,-0.2,0)
        wrapperNode.eulerAngles = SCNVector3(-90,180,0)
        wrapperNode.scale = SCNVector3(0.5,0.5,0.5)
        addChildNode(wrapperNode)
    }
}
