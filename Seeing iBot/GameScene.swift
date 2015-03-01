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
        var velocityTick:CADisplayLink = CADisplayLink(target: self, selector: "joystickMovement")
        velocityTick.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        self.addChild(self.joystickNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func joystickNode() -> Joystick {
        var joystick:Joystick
        
        var jsthumb = SKSpriteNode(imageNamed: "joystick")
        var jsBackdrop = SKSpriteNode(imageNamed: "dpad")
        
        joystick = Joystick(thumb: jsthumb, andBackdrop: jsBackdrop)
        joystick.position = CGPointMake(jsBackdrop.size.width * 5, self.size.height/1.5)
        joystick.name = "playerJoystick"
        
        return joystick
    }
    
    func joystickMovement() {
        var joystick:Joystick = self.childNodeWithName("playerJoystick") as Joystick
        
        if ((joystick.velocity.x != 0 || joystick.velocity.y != 0) && (self.speed == 1))
        {
            // TODO: send movement commands to Arduino
            println("x: ")
            println(joystick.velocity.x)
            println("y: ")
            println(joystick.velocity.y)
            
            //println(joystick.angularVelocity)
        }
    }
}
