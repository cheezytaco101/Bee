
Viewport v = new Viewport();

void draw(){

  v.draw_viewport();

}

class Viewport {
  
  ArrayList<Node> root_tree = new ArrayList<Node>();

  //Viewport (int size_x, int size_y) {
  
    //size(size_x, size_y);
  
  //}
  
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
      
      root_tree.get(draw_order.get(i)).draw_self();
      
    }
    
  }
}


public abstract class Node {
  
  PVector position = new PVector();
  int draw_layer = 0;
  ArrayList<Node> node_tree = new ArrayList<Node>();

  Node (PVector pos, int layer) {
    
    position = pos;
    draw_layer = layer;
    
  }
  
  public abstract void script();
  
  public abstract void draw_self();

}

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
