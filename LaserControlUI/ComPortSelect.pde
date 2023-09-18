class ComPortSelect
{
    ComPortSelect(ControlP5 parent)
    {
       this.parent = parent; 
       
       selectBox = parent.addDropdownList("Serial Ports")
          .setPosition(width/2, 20)

          ;
       String [] comPorts = Serial.list();
       for (int i=0;i<comPorts.length;i++) {
        selectBox.addItem(comPorts[i], i);
      }
    }
    
    void updateList()
    {
      selectBox.clearItems();
      String [] comPorts = Serial.list();
       for (int i=0;i<comPorts.length;i++) {
        selectBox.addItem(comPorts[i], i);
      }
      
    }
    void select( ControlEvent theEvent )
    {
       String [] comPorts = Serial.list();
       selectedPort = comPorts[(int)theEvent.getValue()];
    }
     String getSelected()
     {
        return selectedPort; 
     }
    
      String selectedPort = "COM6";
      ControlP5 parent;
      DropdownList selectBox;
}
