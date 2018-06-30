//
//  Dinosaur.swift
//  drone
//
//  Created by Pedro Antonio Vazquez Rodriguez on 21/06/18.
//  Copyright © 2018 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import ARKit

class Dinosaur: SCNNode {
    func loadModel() {
        guard  let virtualObjectScene = SCNScene(named: "trex.scn") else {
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        wrapperNode.position = SCNVector3 (1,0,1)
        wrapperNode.scale = SCNVector3(0.1,0.1,0.1)
        addChildNode(wrapperNode)
    }
}
