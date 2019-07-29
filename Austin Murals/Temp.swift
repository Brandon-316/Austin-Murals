//
//  ViewController.swift
//  Austin Murals
//
//  Created by Brandon Mahoney on 7/21/19.
//  Copyright © 2019 Brandon Mahoney. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class tViewController: UIViewController {
    
    
    //MARK: - Properties
    var configuration = ARImageTrackingConfiguration()
    var currentSelectedNode: SCNNode?
    
    var centerLocation: CGPoint {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        return CGPoint(x:screenWidth/2,y:screenHeight/2)
    }
    
    var hitCount: Int = 0
    
    //MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "People", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 13
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    //MARK: - Methods
    func handleOverlay(for node: SCNNode) {
        print("Handling overlay")
        //Check that overlay has not been added yet
        print(node != currentSelectedNode)
        print("\nnode: \(node)")
        print("\ncurrentSelectedNode: \(currentSelectedNode)\n")
        guard node != currentSelectedNode else { print("node != currentSelectedNode"); return }
        
        //Check if an overlay is already present
        if let currentNode = currentSelectedNode {
            if currentSelectedNode != node {
                removeOverlay(for: currentNode)
            } else {
                //Overlay for nod already visiblez
                print("Overlay for nod already visible")
                return
            }
        }
        
        addOverlay(for: node)
        self.currentSelectedNode = node
    }
    
    func addOverlay(for node: SCNNode) {
        print("Adding overlay")
        
        guard let name = node.name else { return }
        guard let person = People(rawValue: name) else { return }
        
        nameLabel.text = person.title
        
        node.geometry?.materials.first?.transparency = 0.75
    }
    
    func removeOverlay(for node: SCNNode) {
        print("Removing overlay")
        
        node.geometry?.materials.first?.transparency = 0.0
        
        self.currentSelectedNode = nil
        
    }
}



// MARK: - ARSCNViewDelegate
extension tViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let physicalSize = imageAnchor.referenceImage.physicalSize
            guard let imageName = imageAnchor.referenceImage.name else { return nil }
            guard let person = People(rawValue: imageName) else { return nil }
            
            let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)
            //            plane.firstMaterial?.diffuse.contents = UIColor.clear
            
            guard let image = UIImage(named: person.overlay) else { return nil }
            plane.firstMaterial?.diffuse.contents = image
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            planeNode.name = person.overlay
            
            planeNode.geometry?.materials.first?.transparency = 0.0
            
            node.addChildNode(planeNode)
            
            print("\n\nnode added: \(person.overlay)\n\n")
        }
        
        return node
    }
    
    
    //Check current fram for hit on node
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let results = sceneView.hitTest(centerLocation, options: [SCNHitTestOption.searchMode: 1])
        print("hitTest: \(results)")
        
        //If only one result add overlay
        if results.count == 1 {
            print("Result == 1")
            guard let node = results.first?.node else { return }
            
            self.handleOverlay(for: node)
            
            //If more than one result find node closest to center
        } else if results.count > 1 {
            print("Result > 1")
            var people: [Person] = []
            
            for result in results {
                let node = result.node
                let person = Person.init(node: node, renderer: renderer, centerLocation: centerLocation)
                people.append(person)
            }
            
            //Sort nodes by distance to center of screen
            people.sort(by: { $0.distanceToCenter <  $1.distanceToCenter })
            
            //Get node closest to center of screen
            guard let node = people.first?.node else { return }
            
            handleOverlay(for: node)
            
            //Results is empty, no node is being hit
        } else {
            print("Result == 0")
            if let currentNode = self.currentSelectedNode {
                removeOverlay(for: currentNode)
            }
        }
        
    }
    
}




//MARK: - Session Methods
//For bug
//https://stackoverflow.com/questions/45655562/apple-ios-arkit-a-sensor-failed-to-deliver-the-required-input-error-and-stops
extension tViewController {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("Session failed. Changing worldAlignment property.")
        print(error.localizedDescription)
        
        if let arError = error as? ARError {
            switch arError.errorCode {
            case 102:
                configuration.worldAlignment = .gravity
                restartSessionWithoutDelete()
            default:
                restartSessionWithoutDelete()
            }
        }
    }
    
    func restartSessionWithoutDelete() {
        // Restart session with a different worldAlignment - prevents bug from crashing app
        self.sceneView.session.pause()
        
        self.sceneView.session.run(configuration, options: [
            .resetTracking,
            .removeExistingAnchors])
    }
}
