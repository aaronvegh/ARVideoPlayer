//
//  ViewController.swift
//  ARVideoPlayer
//
//  Created by Aaron Vegh on 2018-02-24.
//  Copyright © 2018 Aaron Vegh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlayerViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.handleTap(sender:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal

        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }


    // MARK: Gesture handlers

    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            guard let currentFrame = sceneView.session.currentFrame else { return }
            let videoPlayerNode = VideoPlayerNode()

            let size = CGSize(width: 1.0, height: 0.65)
            let viewerPlane = SCNPlane(width: size.width, height: size.height)

            let planeNode = SCNNode(geometry: viewerPlane)
            planeNode.addChildNode(videoPlayerNode)
            sceneView.scene.rootNode.addChildNode(planeNode)

            var translation = matrix_identity_float4x4
            translation.columns.3.z = -1.5
            planeNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        }
    }

}
