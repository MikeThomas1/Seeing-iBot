//
//  GameScene.swift
//  test
//
//  Created by Michael Thomas on 3/1/15.
//  Copyright (c) 2015 Mike Thomas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        let velocityTick:CADisplayLink = CADisplayLink(target: self, selector: "joystickMovement")
        velocityTick.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        addChild(joystickNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    private func joystickNode() -> Joystick {
        var joystick:Joystick
        
        let jsthumb = SKSpriteNode(imageNamed: "joystick")
        let jsBackdrop = SKSpriteNode(imageNamed: "dpad")
        
        joystick = Joystick(thumb: jsthumb, andBackdrop: jsBackdrop)
        joystick.position = CGPointMake(size.width/2, size.height/2)
        joystick.name = "playerJoystick"
        
        return joystick
    }
    
    func joystickMovement() {
        guard let joystick:Joystick = childNodeWithName("playerJoystick") as? Joystick else {
            return
        }
        
        if ((joystick.velocity.x != 0 || joystick.velocity.y != 0) && (self.speed == 1)) {
            // TODO: send movement commands to Raspberry Pi
            print("x: ")
            print(joystick.velocity.x)
            print("y: ")
            print(joystick.velocity.y)
        }
    }
}
