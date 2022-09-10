
//This is Bee engine 0.1, a small processing game engine I'm working on for fun

//The genesis of this project arose yesterday (September 8th 2022), when my programming for game design teacher gave me an assignment to draw shapes on a screen.
//Bored by the idea, I instead started work on a simple node based game engine, emulating the design of the Godot engine.
//Presently, this is the very basis of the project, with the intention of it being fully extensible to suit whatever needs I may have.

//In order to add the engine to your project, simply import the project at the top of your code.
//The variable 'v' references the viewport, which acts as the root handler of the program.
//To add a new node to the viewport, simply use add() to add it to the root_tree.
//To add a node, start by extending an existing abstract node class, setting it's params with super(), and then adding the script() function.
//The script is an optional function, which allows you to handle the nodes code locally, this is useful for creating easily instantiable nodes, like enemies or collision blocks.

//TODO : 
//Add functions for nodes to inherit the movement of their parents
//Create collisions
//Add input handler

//Below I'll go into further detail on specific classes and their functions

//On import creates the v variable, which acts as the viewport, the name can be changed if you'd like, just also change all of it's references to avoid errors
Viewport v = new Viewport();

//Called each frame, draws down the viewport heirarchy
void draw(){

  v.draw_viewport();

}

//The handler for all children nodes and default processes, primarily the draw order of nodes
class Viewport {
  
  //All sub root level nodes should be added to root_tree, which is inherent to the viewport
  ArrayList<Node> root_tree = new ArrayList<Node>();
  
  //Draws all of it's children in order according to their layer, the higher layers being drawn on top, and the lower below
  void draw_viewport(){
        
    ArrayList<Integer> draw_order = new ArrayList<Integer>();
    int layer_check = 10;
    
    for(int j = 0; j < layer_check; j++) {
      
      for(int i = 0; root_tree.size() > i; i++) {
                
        if(root_tree.get(i).draw_layer == j) {
          
          draw_order.add(i);
          
        }
        
      }
        
    }
    
    for (int i = 0; i < draw_order.size(); i++) {
      
      root_tree.get(draw_order.get(i)).draw_children();
      root_tree.get(draw_order.get(i)).draw_self();
      
    }
    
  }
}


//The default node class, doesn't contain any properties other than the basic structure for all further nodes, only takes positional and layer values atm
public abstract class Node {
  
  PVector position = new PVector();
  int draw_layer = 0;
  ArrayList<Node> node_tree = new ArrayList<Node>();

  Node (PVector pos, int layer) {
    
    position = pos;
    draw_layer = layer;
    
  }
  
  //Draws all children, and subsequent children on respective layers
  void draw_children(){
        
    ArrayList<Integer> draw_order = new ArrayList<Integer>();
    int layer_check = 10;
    
    for(int j = 0; j < layer_check; j++) {
      
      for(int i = 0; node_tree.size() > i; i++) {
                
        if(node_tree.get(i).draw_layer == j) {
          
          draw_order.add(i);
          
        }
        
      }
        
    }
    
    for (int i = 0; i < draw_order.size(); i++) {
      
      node_tree.get(draw_order.get(i)).draw_self();
      
    }
    
  }
  
  //Can be used to run custom user made scripts
  public abstract void script();
  
  //Can be used to draw any visual nodes
  public abstract void draw_self();

}


//Extension of default Node, which draws a rectangle at it's position, you can also select the colour.
public abstract class RectNode extends Node {
    
  PVector dimentions = new PVector();
  int colour = 0;
  
  RectNode(PVector pos, int layer, PVector dim, int col) {
    
    super(pos, layer);
    dimentions = dim;
    colour = col;
    
  }
    
  public void draw_self() {
    fill(colour);
    rect(position.x, position.y, dimentions.x, dimentions.y); 
  }
    
}
