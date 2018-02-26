//
//  VideoPlayerNode.swift
//  ARVideoPlayer
//
//  Created by Aaron Vegh on 2018-02-24.
//  Copyright © 2018 Aaron Vegh. All rights reserved.
//

import ARKit
import SceneKit
import AVFoundation

class VideoPlayerNode: SCNNode {

    var videoRendererNode: SCNNode

    var player: AVPlayer

    override init() {
        player = AVPlayer(url: Bundle.main.url(forResource: "blackpanther", withExtension: "mp4")!)
        let playerMaterial = SCNMaterial()
        playerMaterial.diffuse.contents = player


        videoRendererNode = SCNNode()
        videoRendererNode.geometry = SCNBox(width: 1.0,
                                            height: 0.65,
                                            length: 0.005,
                                            chamferRadius: 0)
        videoRendererNode.position = SCNVector3Make(0, 0, 0)
        videoRendererNode.name = "video_renderer_node"

        videoRendererNode.geometry?.firstMaterial = playerMaterial
        player.play()

        super.init()
        addChildNode(videoRendererNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
